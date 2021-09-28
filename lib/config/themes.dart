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
      scaffoldBackgroundColor: Colors.white,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xffffa447)),
      textTheme: TextTheme(
        headline3: GoogleFonts.raleway(
            color: const Color(0xff2E3142), fontWeight: FontWeight.bold),
        headline4: GoogleFonts.raleway(
            color: const Color(0xff2E3142), fontWeight: FontWeight.bold),
        headline6: GoogleFonts.raleway(
            color: const Color(0xff2E3142), fontWeight: FontWeight.bold),
        subtitle1: GoogleFonts.raleway(
            color: const Color(0xff2E3142), fontWeight: FontWeight.bold),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xff2E3142),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xffffa447)),
      textTheme: TextTheme(
        headline3: GoogleFonts.raleway(
            color: Colors.white, fontWeight: FontWeight.bold),
        headline4: GoogleFonts.raleway(
            color: Colors.white, fontWeight: FontWeight.bold),
        headline6: GoogleFonts.raleway(
            color: Colors.white, fontWeight: FontWeight.bold),
        subtitle1: GoogleFonts.raleway(color: Colors.white),
      ),
    );
  }
}
