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
  static const successColor = Colors.green;
  static const List<Color> categoryColors = [
    Color(0xFF0A73EB), // Ink Blue
    Color(0xFF26A942), // Grass Green
    Color(0xFFDE3535), // Danger Red
    Color(0xFF9A3CEC), // Voilet
    Color(0xFF7CD913), // Parrot Green
    Color(0xFFF74186), // Candy Pink
    Color(0xFFF6B041), // Fanta
    Color(0xFF5DDFEE), // Cyan
    Color(0xFFFF6F00), // Dark Orange
    Color(0xFFA9B63F), // Pop Green
    Color(0xFF001757), // Navy Blue
    Color(0xFF2CC990), // Distember Green
    Color(0xFFEE8C3D), // Biscuit
    Color(0xFF39B4FF), // Dark Sky Blue
    Color(0xFF837AF2), // Indigo
    Color(0xFFEAD339), // Yellow
    Color(0xFF2CBCBD), // Teal
    Color(0xFFCE9965), // Brownish Orange
    Color(0xFF5D5FB3), // Dark Voilet
    Color(0xFF188C8B), // Dark Teal
    Color(0xFFD43B99), // Dark Candy
    Color(0xFFCFCB51), // Caution Yellow
    Color(0xFFDF5F37), // Saffron
    Color(0xFF56CA4E), // Venom
    Color(0xFFB353CB), // Paint Pink
    Color(0xFF8B1650), // Crimson
    Color(0xFF8DCCAC), // Gray Green
    Color(0xFF00468B), // Blueish Blue
    Color(0xFF003D00), // Tree Green
    Color(0xFF93B728), // Yellowish Green
  ];

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
