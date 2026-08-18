import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_photo_frame/l10n/app_localizations.dart';

/// Locales the app ships. Keep in sync with `supportedLocales` in main.dart.
const _expectedLocales = ['en', 'de', 'zh'];

/// Reads an .arb file and returns only the translatable keys (skipping the
/// `@`-prefixed metadata and the `@@locale` header).
Set<String> _translationKeys(String locale) {
  final file = File('lib/l10n/app_$locale.arb');
  expect(file.existsSync(), isTrue, reason: '${file.path} is missing');
  final decoded = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  return decoded.keys.where((k) => !k.startsWith('@')).toSet();
}

void main() {
  test('every locale translates exactly the same keys as English', () {
    final english = _translationKeys('en');
    expect(english, isNotEmpty);

    for (final code in _expectedLocales.where((c) => c != 'en')) {
      final keys = _translationKeys(code);
      expect(
        english.difference(keys),
        isEmpty,
        reason: 'app_$code.arb is missing translations',
      );
      expect(
        keys.difference(english),
        isEmpty,
        reason: 'app_$code.arb has keys that no longer exist in English',
      );
    }
  });

  test('every expected locale is supported by the delegate', () {
    final supported = AppLocalizations.supportedLocales
        .map((l) => l.languageCode)
        .toList();
    for (final code in _expectedLocales) {
      expect(supported, contains(code), reason: 'locale $code is not generated');
    }
  });

  testWidgets('no locale falls back to an untranslated English string',
      (tester) async {
    // Sample of strings from different sections, including the ones added for
    // the transition effects and the startup config notice.
    String sample(AppLocalizations l) => [
          l.settings,
          l.sectionSlideshow,
          l.slideDuration,
          l.transitionEffect,
          l.transitionEffectFade,
          l.transitionEffectBlur,
          l.transitionEffectRandom,
          l.noPhotosFound,
          l.configRecoveredFromBackup,
          l.configResetToDefaults,
          l.sectionPhotoSource,
          l.about,
        ].join('|');

    final byLocale = <String, String>{};

    for (final code in _expectedLocales) {
      late AppLocalizations l10n;
      await tester.pumpWidget(
        Localizations(
          locale: Locale(code),
          delegates: const [
            AppLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          child: Builder(
            builder: (context) {
              l10n = AppLocalizations.of(context)!;
              return const SizedBox();
            },
          ),
        ),
      );
      byLocale[code] = sample(l10n);
    }

    // Each locale must produce a distinct set of strings - identical output
    // means a translation file is missing and English is leaking through.
    expect(byLocale['de'], isNot(byLocale['en']));
    expect(byLocale['zh'], isNot(byLocale['en']));
    expect(byLocale['zh'], isNot(byLocale['de']));

    // Spot check that the Chinese strings really are Chinese.
    expect(byLocale['zh'], contains('设置'));
    expect(byLocale['zh'], contains('淡入淡出'));
  });
}
