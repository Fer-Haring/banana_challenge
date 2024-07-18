import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF9E007E),
        // Text
        textTheme: TextTheme(
          titleLarge: GoogleFonts.montserratAlternates(),
          titleMedium: GoogleFonts.montserratAlternates(fontSize: 35),
          headlineLarge: GoogleFonts.montserratAlternates(fontSize: 24),
          headlineMedium: GoogleFonts.montserratAlternates(fontSize: 20),
          headlineSmall: GoogleFonts.montserratAlternates(fontSize: 16),
        ),
        // Inputs
        dividerColor: const Color.fromARGB(200, 229, 229, 229),
        shadowColor: const Color(0xFF4F4F4F),
      );
}
