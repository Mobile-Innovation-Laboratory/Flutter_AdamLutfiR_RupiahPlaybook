import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightMode = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      shadowColor: const Color.fromARGB(255, 135, 135, 135),
      elevation: 2,
      surfaceTintColor: Colors.transparent,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white, elevation: 2),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
        fontSize: 36.sp,
        fontWeight: FontWeight.w800,
      ),
      displayMedium: GoogleFonts.roboto(
        fontSize: 24.sp,
        fontWeight: FontWeight.w800,
      ),
      displaySmall: GoogleFonts.roboto(
        fontSize: 20.sp,
        fontWeight: FontWeight.w800,
      ),
      headlineLarge: GoogleFonts.roboto(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: GoogleFonts.roboto(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.roboto(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.roboto(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: GoogleFonts.roboto(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: GoogleFonts.roboto(
        fontSize: 14.sp,
      ),
      labelMedium: GoogleFonts.roboto(
        fontSize: 12.sp,
      ),
      labelSmall: GoogleFonts.roboto(
        fontSize: 10.sp,
      ),
    ),
    focusColor: const Color(0xFF00623B),
    cardColor: const Color.fromARGB(255, 231, 231, 231),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.roboto(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF344E41),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF00623B),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF344E41),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.roboto(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: const WidgetStatePropertyAll(
          Color(0xFF00623B),
        ),
      ),
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.black),
      ),
    ),
  );

  static final ThemeData darkMode = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black, elevation: 2),
    appBarTheme: AppBarTheme(
      color: Colors.black,
      shadowColor: const Color.fromARGB(255, 122, 122, 122),
      elevation: 2,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFFFCFFFE),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
        fontSize: 36.sp,
        fontWeight: FontWeight.w800,
        color: const Color(0xFFFCFFFE),
      ),
      displayMedium: GoogleFonts.roboto(
        fontSize: 24.sp,
        fontWeight: FontWeight.w800,
        color: const Color(0xFFFCFFFE),
      ),
      displaySmall: GoogleFonts.roboto(
        fontSize: 20.sp,
        fontWeight: FontWeight.w800,
        color: const Color(0xFFFCFFFE),
      ),
      headlineLarge: GoogleFonts.roboto(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFFFCFFFE),
      ),
      headlineMedium: GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFFFCFFFE),
      ),
      headlineSmall: GoogleFonts.roboto(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFFFCFFFE),
      ),
      titleLarge: GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFFFCFFFE),
      ),
      titleMedium: GoogleFonts.roboto(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFFFCFFFE),
      ),
      titleSmall: GoogleFonts.roboto(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFFFCFFFE),
      ),
      bodyLarge: GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFFFCFFFE),
      ),
      bodyMedium: GoogleFonts.roboto(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFFFCFFFE),
      ),
      bodySmall: GoogleFonts.roboto(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: const Color(0xFFFCFFFE),
      ),
      labelLarge: GoogleFonts.roboto(
        fontSize: 14.sp,
        color: const Color(0xFFFCFFFE),
      ),
      labelMedium: GoogleFonts.roboto(
        fontSize: 12.sp,
        color: const Color(0xFFFCFFFE),
      ),
      labelSmall: GoogleFonts.roboto(
        fontSize: 10.sp,
        color: const Color(0xFFFCFFFE),
      ),
    ),
    focusColor: const Color(0xFF00623B),
    cardColor: const Color.fromARGB(255, 43, 43, 43),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: Colors.white.withOpacity(0.9),
      prefixStyle: GoogleFonts.roboto(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(0.9),
      ),
      hintStyle: GoogleFonts.roboto(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(0.8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF00623B),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFF00623B),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          GoogleFonts.roboto(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: const WidgetStatePropertyAll(
          Color(0xFF00623B),
        ),
      ),
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.white),
      ),
    ),
  );
}
