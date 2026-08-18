import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_photo_frame/domain/interfaces/config_provider.dart';
import 'package:open_photo_frame/domain/interfaces/photo_repository.dart';
import 'package:open_photo_frame/domain/interfaces/playlist_strategy.dart';
import 'package:open_photo_frame/domain/interfaces/storage_provider.dart';
import 'package:open_photo_frame/domain/interfaces/sync_provider.dart';
import 'package:open_photo_frame/domain/models/photo_entry.dart';
import 'package:open_photo_frame/infrastructure/services/photo_service.dart';

/// Hands out photos strictly in order, so peek/next ordering is observable.
class _SequentialStrategy implements PlaylistStrategy {
  int _index = 0;

  @override
  String get id => 'sequential';

  @override
  String get name => 'Sequential';

  @override
  PhotoEntry? nextPhoto(List<PhotoEntry> photos) {
    if (photos.isEmpty) return null;
    final photo = photos[_index % photos.length];
    _index++;
    return photo;
  }
}

class _FakeRepository implements PhotoRepository {
  _FakeRepository(this.photos);

  @override
  final List<PhotoEntry> photos;

  final _controller = StreamController<void>.broadcast();

  @override
  Stream<void> get onPhotosChanged => _controller.stream;

  @override
  Future<void> initialize() async {}

  @override
  Future<void> reinitialize() async {}

  @override
  void dispose() => _controller.close();
}

class _FakeStorageProvider implements StorageProvider {
  final _controller = StreamController<void>.broadcast();

  @override
  Future<Directory> getPhotoDirectory() async => Directory.systemTemp;

  @override
  bool get isReadOnly => true;

  @override
  Stream<void> get onDirectoryChanged => _controller.stream;

  void dispose() => _controller.close();
}

class _FakeSyncProvider implements SyncProvider {
  @override
  String get id => 'fake';

  @override
  Future<void> sync({
    bool deleteOrphanedFiles = false,
    SyncProgressCallback? onProgress,
  }) async {}
}

class _FakeConfigProvider extends ChangeNotifier implements ConfigProvider {
  @override
  int get syncIntervalMinutes => 0; // disable the background sync loop

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late _FakeRepository repository;
  late _FakeStorageProvider storageProvider;
  late PhotoService service;
  late List<PhotoEntry> photos;

  setUp(() {
    photos = [
      for (final name in ['a', 'b', 'c'])
        PhotoEntry(
          file: File('/tmp/$name.jpg'),
          date: DateTime(2024, 1, 1),
          sizeBytes: 1024,
        ),
    ];
    repository = _FakeRepository(photos);
    storageProvider = _FakeStorageProvider();
    service = PhotoService(
      syncProviderFactory: () => _FakeSyncProvider(),
      playlistStrategy: _SequentialStrategy(),
      repository: repository,
      configProvider: _FakeConfigProvider(),
      storageProvider: storageProvider,
    );
  });

  tearDown(() {
    service.dispose();
    storageProvider.dispose();
  });

  test('peekNextPhoto returns what nextPhoto will hand out next', () {
    expect(service.nextPhoto()?.file.path, '/tmp/a.jpg');

    final peeked = service.peekNextPhoto();
    expect(peeked?.file.path, '/tmp/b.jpg');

    // Peeking must not consume the entry.
    expect(service.nextPhoto()?.file.path, '/tmp/b.jpg');
    expect(service.nextPhoto()?.file.path, '/tmp/c.jpg');
  });

  test('repeated peeks return the same photo', () {
    service.nextPhoto();
    expect(service.peekNextPhoto()?.file.path, '/tmp/b.jpg');
    expect(service.peekNextPhoto()?.file.path, '/tmp/b.jpg');
    expect(service.nextPhoto()?.file.path, '/tmp/b.jpg');
  });

  test('peeking does not break backwards navigation', () {
    service.nextPhoto(); // a
    service.nextPhoto(); // b
    service.peekNextPhoto(); // stages c

    expect(service.previousPhoto()?.file.path, '/tmp/a.jpg');
    expect(service.nextPhoto()?.file.path, '/tmp/b.jpg');
    expect(service.nextPhoto()?.file.path, '/tmp/c.jpg');
  });

  test('peekNextPhoto returns null when there are no photos', () {
    photos.clear();
    expect(service.peekNextPhoto(), isNull);
  });
}
