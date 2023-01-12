import 'package:flutter/material.dart';
class Constants{

  static String appName = "Emoinu Foods";

  //Colors for theme
//  Color(0xfffcfcff);
  static Color lightPrimary = const Color(0xfffcfcff);
  static Color? darkPrimary = Colors.blueGrey[900];
  static Color lightAccent = Colors.cyan;
  static Color? darkAccent = Colors.indigo[100];
  static Color lightBG = const Color(0xfffcfcff);
  static Color? darkBG = Colors.blueGrey[900];
  static Color? ratingBG = Colors.red[600];

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      toolbarTextStyle: TextTheme(
        subtitle1: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).bodyText2, titleTextStyle: TextTheme(
      subtitle1: TextStyle(
        color: darkBG,
        fontSize: 18.0,
        fontWeight: FontWeight.w800,
      ),
    ).headline6,
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
    ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: lightAccent),
    textSelectionTheme: TextSelectionThemeData(cursorColor: lightAccent),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBG,
    appBarTheme: AppBarTheme(
      toolbarTextStyle: TextTheme(
        subtitle1: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).bodyText2, titleTextStyle: TextTheme(
      subtitle1: TextStyle(
        color: lightBG,
        fontSize: 18.0,
        fontWeight: FontWeight.w800,
      ),
    ).headline6,
//      iconTheme: IconThemeData(
//        color: darkAccent,
//      ),
    ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: darkAccent),
    textSelectionTheme: TextSelectionThemeData(cursorColor: darkAccent),
  );


}