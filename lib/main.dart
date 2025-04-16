import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freiightflow/core/constants.dart';
import 'package:freiightflow/notifiers/locale_notifier.dart';
import 'package:freiightflow/pages/welcome_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadSavedLocale();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, _) {
        return MaterialApp(
          locale: locale,
          supportedLocales: [Locale('en'), Locale('he')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          home: WelcomePage(),
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
            ),
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: materialColor,
              backgroundColor: Colors.transparent,
            ),
          ),
        );
      },
    );
  }
}
