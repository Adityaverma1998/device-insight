import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      textTheme: _textTheme,
      // checkboxTheme: CheckboxThemeData(
      //   shape: BeveledRectangleBorder(),
      //   checkColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      //     if (states.contains(MaterialState.selected)) {
      //       // Color when the checkbox is checked
      //       return Colors.white;  // Replace with your desired color
      //     }
      //     // Color when the checkbox is unchecked
      //     return null; // You can return null for the default color
      //   }),
      // ),

      primaryColor: colorScheme.primary,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.inversePrimary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFFAFBFB)),
      ),
      // badgeTheme: colorScheme.secondaryContainer,
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.primaryContainer,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      dividerColor: Color.fromRGBO(147, 147, 147, 1),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.titleMedium!.apply(color: _darkFillColor),
      ),
      colorScheme:
          colorScheme.copyWith(background: colorScheme.secondaryContainer),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFFAFBFB),
    primaryContainer: Color.fromRGBO(15, 25, 34, 1),
    // secondary: Color.fromRGBO(19, 196, 159, 1),
    secondary: Color.fromRGBO(61, 61, 61, 1),
    secondaryContainer: Color.fromRGBO(19, 196, 159, 1),
    background: Color.fromRGBO(15, 25, 34, 1),
    surface: Color(0xFFFAFBFB),
    onBackground: Color.fromRGBO(221, 221, 221, 1),
    inversePrimary: Color.fromRGBO(30, 46, 59, 1),
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: Color.fromRGBO(217, 217, 217, 1),
    onSecondary: Color.fromRGBO(9, 53, 44, 1),
    onSurface: Color(0xFF000000),
    brightness: Brightness.light,
    onErrorContainer: Color.fromRGBO(217, 21, 21, 1),
    outline: Color.fromRGBO(116, 125, 128, 0.50),
    onPrimaryContainer: Color.fromRGBO(156, 156, 156, 1),
    onSecondaryContainer: Color.fromRGBO(53, 78, 99, 1),
    inverseSurface: Color.fromRGBO(68, 67, 67, 1),
    onInverseSurface: Color.fromRGBO(142, 142, 142, 1),
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFF1E2E3B),
    primaryContainer: Color.fromRGBO(15, 25, 34, 1),
    secondary: Colors.red,
    secondaryContainer: Color(0xFF451B6F),

    background: Color(0xFF241E30),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF),
    // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headlineMedium: GoogleFonts.lato(
      fontWeight: _bold,
      fontSize: 20.0,
      letterSpacing: 0.15,
    ),
    bodySmall: GoogleFonts.lato(
      fontWeight: _semiBold,
      fontSize: 16.0,
      letterSpacing: 0.2,
    ),
    headlineSmall: GoogleFonts.lato(
      fontWeight: _medium,
      fontSize: 16.0,
      letterSpacing: 0.15,
    ),
    titleMedium: GoogleFonts.lato(
      fontWeight: _medium,
      fontSize: 16.0,
      letterSpacing: 0.15,
    ),
    labelSmall: GoogleFonts.lato(
      fontWeight: _medium,
      fontSize: 10.0,
      letterSpacing: 0.1,
    ),
    bodyLarge: GoogleFonts.lato(
      fontWeight: _regular,
      fontSize: 14.0,
      letterSpacing: 0.25,
    ),
    titleSmall: GoogleFonts.lato(
      fontWeight: _medium,
      fontSize: 14.0,
      letterSpacing: 0.15,
    ),
    bodyMedium: GoogleFonts.lato(
      fontWeight: _regular,
      fontSize: 16.0,
      letterSpacing: 0.2,
    ),
    titleLarge: GoogleFonts.lato(
      fontWeight: _regular,
      fontSize: 24.0,
      letterSpacing: 0.2,
    ),
    labelLarge: GoogleFonts.lato(
      fontWeight: _semiBold,
      fontSize: 14.0,
      letterSpacing: 0.1,
    ),
    labelMedium: GoogleFonts.lato(
      fontWeight: _regular,
      fontSize: 12.0,
      letterSpacing: 0.1,
    ),
  );
}
