import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_photo_frame/ui/widgets/slide_transitions.dart';

void main() {
  group('TransitionEffect', () {
    test('ids are unique and stable across a fromId round trip', () {
      final ids = TransitionEffect.values.map((e) => e.id).toList();
      expect(ids.toSet().length, ids.length);

      for (final effect in TransitionEffect.values) {
        expect(TransitionEffect.fromId(effect.id), effect);
      }
    });

    test('unknown or missing ids fall back to fade', () {
      expect(TransitionEffect.fromId(null), TransitionEffect.fade);
      expect(TransitionEffect.fromId(''), TransitionEffect.fade);
      expect(TransitionEffect.fromId('does_not_exist'), TransitionEffect.fade);
    });

    test('concrete contains every effect except random', () {
      expect(
        TransitionEffect.concrete,
        TransitionEffect.values.where((e) => e != TransitionEffect.random).toList(),
      );
    });

    test('resolve() leaves concrete effects untouched', () {
      for (final effect in TransitionEffect.concrete) {
        expect(effect.resolve(), effect);
      }
    });

    test('resolve() turns random into a concrete effect', () {
      for (var seed = 0; seed < 50; seed++) {
        final resolved = TransitionEffect.random.resolve(math.Random(seed));
        expect(TransitionEffect.concrete, contains(resolved));
      }
    });
  });

  group('buildSlideTransition', () {
    testWidgets('every effect renders its child at both animation ends',
        (tester) async {
      for (final effect in TransitionEffect.concrete) {
        for (final value in [0.0, 0.5, 1.0]) {
          await tester.pumpWidget(
            MaterialApp(
              home: buildSlideTransition(
                effect: effect,
                animation: AlwaysStoppedAnimation<double>(value),
                child: const SizedBox(key: ValueKey('photo'), width: 10, height: 10),
              ),
            ),
          );
          expect(
            find.byKey(const ValueKey('photo')),
            findsOneWidget,
            reason: 'effect ${effect.id} at $value',
          );
        }
      }
    });
  });
}
