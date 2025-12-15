import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Modern Color Palette
  static const Color primaryColor = Color(0xFF5B5E7E);
  static const Color secondaryColor = Color(0xFF8B8FA3);
  static const Color accentColor = Color(0xFFFF6B6B);
  static const Color successColor = Color(0xFF51CF66);
  static const Color warningColor = Color(0xFFFFA500);
  static const Color errorColor = Color(0xFFFF6B6B);
  
  static const Color darkBg = Color(0xFF0F1419);
  static const Color lightBg = Color(0xFFFAFAFC);
  static const Color lightCardBg = Color(0xFFFFFFFF);
  
  static const Color textPrimary = Color(0xFF1A1D23);
  static const Color textSecondary = Color(0xFF6C7286);
  static const Color textTertiary = Color(0xFFA5AAB5);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: accentColor,
      surface: lightBg,
      surfaceContainer: lightCardBg,
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textPrimary,
      outline: textTertiary,
    ),
    scaffoldBackgroundColor: lightBg,
    
    // Text Theme
    textTheme: GoogleFonts.courierPrimeTextTheme().copyWith(
      displayLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textPrimary,
      ),
      bodyLarge: GoogleFonts.courierPrime(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textPrimary,
      ),
      bodyMedium: GoogleFonts.courierPrime(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textSecondary,
      ),
      bodySmall: GoogleFonts.courierPrime(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textTertiary,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: primaryColor,
        letterSpacing: 0.5,
      ),
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: lightBg,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      iconTheme: const IconThemeData(color: textPrimary),
      titleTextStyle: GoogleFonts.poppins(
        color: textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: lightCardBg,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color(0xFFE8EAEF),
          width: 1,
        ),
      ),
      margin: EdgeInsets.zero,
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 8,
      highlightElevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      extendedPadding: const EdgeInsets.symmetric(horizontal: 24),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF5F6F8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE8EAEF), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE8EAEF), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor, width: 2),
      ),
      hintStyle: GoogleFonts.courierPrime(
        color: textTertiary,
        fontSize: 14,
      ),
      labelStyle: GoogleFonts.poppins(
        color: textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: textTertiary,
      suffixIconColor: textTertiary,
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // Dialog Theme
    dialogTheme: DialogThemeData(
      backgroundColor: lightCardBg,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      contentTextStyle: GoogleFonts.courierPrime(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textSecondary,
      ),
    ),

    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFF5F6F8),
      disabledColor: const Color(0xFFE8EAEF),
      selectedColor: primaryColor,
      secondarySelectedColor: primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      secondaryLabelStyle: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),

    // Bottom Sheet Theme
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: lightCardBg,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),

    // Snackbar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: textPrimary,
      contentTextStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 8,
      behavior: SnackBarBehavior.floating,
      insetPadding: const EdgeInsets.all(16),
    ),

    // Navigation Rail Theme
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: lightCardBg,
      elevation: 0,
      labelType: NavigationRailLabelType.selected,
      indicatorColor: primaryColor.withOpacity(0.1),
      selectedLabelTextStyle: GoogleFonts.poppins(
        color: primaryColor,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelTextStyle: GoogleFonts.poppins(
        color: textTertiary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  // Glassmorphism Decoration
  static BoxDecoration glassDecoration({
    Color? color,
    BorderRadius? borderRadius,
    double? opacity,
  }) {
    return BoxDecoration(
      color: (color ?? Colors.white).withOpacity(opacity ?? 0.1),
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      border: Border.all(
        color: Colors.white.withOpacity(0.2),
        width: 1.5,
      ),
    );
  }

  // Smooth Shadow
  static List<BoxShadow> smoothShadow({double opacity = 0.1}) {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(opacity),
        blurRadius: 24,
        offset: const Offset(0, 8),
      ),
      BoxShadow(
        color: Colors.black.withOpacity(opacity * 0.5),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ];
  }
}