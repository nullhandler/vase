import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const accentColor = Color(0xff03dac6);
  static ColorScheme monetColorScheme =
      ThemeData.dark(useMaterial3: true).colorScheme.copyWith(
            primary: accentColor,
          );
  static const darkGreyColor = Color(0xff1c1b1f);
  static const errorColor = Colors.redAccent;

  static const pieCharColors = {
    'pieColor2': Color(0xffea5f89),
    'pieColor3': Color(0xff57167E),
    'pieColor4': Color(0xffF7B7A3),
    'pieColor5': Color(0xff9B3192),
    'pieColor1': Color(0xfffff1c9)
  };

  static ThemeData defaultTheme = ThemeData.dark(useMaterial3: true).copyWith(
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }),
      colorScheme: ThemeData.dark(useMaterial3: true).colorScheme.copyWith(
            primary: accentColor,
          ),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: accentColor),
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(selectedItemColor: accentColor),
      textTheme: GoogleFonts.latoTextTheme().apply(bodyColor: Colors.white));

  static ThemeData monetTheme = ThemeData.dark(useMaterial3: true).copyWith(
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }),
      colorScheme: monetColorScheme,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: monetColorScheme.primary),
      textTheme: GoogleFonts.latoTextTheme().apply(bodyColor: Colors.white));
}
