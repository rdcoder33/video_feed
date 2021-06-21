import 'package:flutter/material.dart';
import 'package:video_feed/src/ui/Theme/colors.dart';

ThemeData lightThemeData = ThemeData(
  scaffoldBackgroundColor: bgColor,
  primaryColor: primaryColor,
  accentColor: accentColor,
  brightness: Brightness.light,
   primarySwatch: Colors.blue,
  backgroundColor: bgColor,
  appBarTheme: AppBarTheme(
      textTheme: TextTheme(
          headline1: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold))),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: Colors.black,
    ),
    headline2: TextStyle(color: Colors.black87),
    bodyText1: TextStyle(
      color: Colors.black,
    ),
  ),
);

ThemeData darkThemeData = ThemeData(
  scaffoldBackgroundColor: bgColorDark,
  primaryColor: primaryColor,
  accentColor: accentColor,
  primarySwatch: Colors.blue,
  backgroundColor: bgColorDark,
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
      textTheme: TextTheme(
          headline1: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold))),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: Colors.white,
    ),
    headline2: TextStyle(
      color: Colors.white70,
    ),
    bodyText1: TextStyle(
      color: Colors.white,
    ),
  ),
);
