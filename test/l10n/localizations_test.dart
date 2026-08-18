import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_photo_frame/l10n/app_localizations.dart';

/// Locales the app ships. Keep in sync with `supportedLocales` in main.dart.
const _expectedLocales = ['en', 'de', 'zh'];

void main() {
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
