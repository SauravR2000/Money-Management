import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management_app/utils/constants/colors.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
      color: Colors.black,
    )),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.aBeeZee(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: GoogleFonts.aBeeZee(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: GoogleFonts.aBeeZee(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      headlineMedium: GoogleFonts.aBeeZee(
        fontSize: 18,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        textStyle: GoogleFonts.aBeeZee(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 127, 61, 255),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.purple,
    ),
  );
}
