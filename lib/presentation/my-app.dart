
import 'package:device_insight/constant/strings.dart';
import 'package:device_insight/presentation/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp  extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      // theme: _themeStore.darkMode
      //     ? AppThemeData.darkThemeData
      //     : AppThemeData.lightThemeData,
      // routes: Routes.routes,
      // locale: Locale(_languageStore.locale),
      // supportedLocales: _languageStore.supportedLanguages
      //     .map((language) => Locale(language.locale, language.code))
      //     .toList(),
      localizationsDelegates: [
        // A class which loads the translations from JSON files
        // AppLocalizations.delegate,
        // // Built-in localization of basic text for Material widgets
        // GlobalMaterialLocalizations.delegate,
        // // Built-in localization for text direction LTR/RTL
        // GlobalWidgetsLocalizations.delegate,
        // // Built-in localization of basic text for Cupertino widgets
        // GlobalCupertinoLocalizations.delegate,
      ],
      home: HomeScreen(),
    );
  }

}
