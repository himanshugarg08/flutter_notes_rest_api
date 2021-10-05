import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api/config/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme extends ChangeNotifier {
  static bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void changeTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColor.withOpacity(0.2),
        secondary: kDarkColor,
        onPrimary: kDarkColor.withOpacity(0.4),
        surface: kDarkColor.withOpacity(0.8),
        onSurface: kDarkColor.withOpacity(0.1),
      ),
      scaffoldBackgroundColor: kLightColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xffffa447)),
      textTheme: TextTheme(
        headline1:
            GoogleFonts.raleway(color: kDarkColor, fontWeight: FontWeight.bold),
        headline2:
            GoogleFonts.raleway(color: kDarkColor, fontWeight: FontWeight.bold),
        headline3:
            GoogleFonts.raleway(color: kDarkColor, fontWeight: FontWeight.bold),
        headline4:
            GoogleFonts.raleway(color: kDarkColor, fontWeight: FontWeight.bold),
        headline5:
            GoogleFonts.raleway(color: kDarkColor, fontWeight: FontWeight.bold),
        headline6:
            GoogleFonts.raleway(color: kDarkColor, fontWeight: FontWeight.bold),
        subtitle1:
            GoogleFonts.raleway(color: kDarkColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: kLightColor,
        primary: kLightColor,
        onPrimary: const Color(0xffbbc0c9),
        surface: kLightColor.withOpacity(0.6),
        onSurface: kLightColor.withOpacity(1.0),
      ),
      scaffoldBackgroundColor: const Color(0xff2E3142),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xffffa447)),
      textTheme: TextTheme(
        headline1: GoogleFonts.raleway(
            color: kLightColor, fontWeight: FontWeight.bold),
        headline2: GoogleFonts.raleway(
            color: kLightColor, fontWeight: FontWeight.bold),
        headline3: GoogleFonts.raleway(
            color: kLightColor, fontWeight: FontWeight.bold),
        headline4: GoogleFonts.raleway(
            color: kLightColor, fontWeight: FontWeight.bold),
        headline5: GoogleFonts.raleway(
            color: kLightColor, fontWeight: FontWeight.bold),
        headline6: GoogleFonts.raleway(
            color: kLightColor, fontWeight: FontWeight.bold),
        subtitle1: GoogleFonts.raleway(color: kLightColor),
      ),
    );
  }
}
