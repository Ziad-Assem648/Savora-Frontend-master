import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  // ---------------- DARK THEME ----------------
  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.espresso,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.saffron,
        secondary: AppColors.terracotta,
        surface: AppColors.espressoSoft,
        onPrimary: AppColors.espresso,
        onSurface: AppColors.cream,
      ),

      textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(
        bodyColor: AppColors.cream,
        displayColor: AppColors.cream,
      ),

      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
    );
  }

  // ---------------- LIGHT THEME ----------------
  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);

    final colorScheme = base.colorScheme.copyWith(
      brightness: Brightness.light,

      // --- Brand ---
      primary: AppColors.luxuryAccent,
      onPrimary: AppColors.espresso,

      secondary: AppColors.terracotta,
      onSecondary: Colors.white,

      // --- Background system ---
      background: AppColors.luxuryBackground,
      onBackground: AppColors.luxuryText,

      surface: AppColors.luxurySurface,
      onSurface: AppColors.luxuryText,

      surfaceContainerLowest: AppColors.luxuryBackground,
      surfaceContainerLow: AppColors.offWhite,
      surfaceContainer: AppColors.luxuryCard,
      surfaceContainerHigh: AppColors.luxuryCard,
      surfaceContainerHighest: AppColors.offWhite,

      outline: AppColors.lightBorder,
      outlineVariant: AppColors.lightBorder,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.luxuryBackground,
      canvasColor: AppColors.luxuryBackground,

      // ---------------- CARDS ----------------
      cardTheme: CardThemeData(
        color: AppColors.luxuryCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: AppColors.lightBorder.withOpacity(.35),
          ),
        ),
      ),

      // ---------------- APP BAR ----------------
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.luxuryBackground,
        foregroundColor: AppColors.luxuryText,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
      ),

      // ---------------- BOTTOM SHEET ----------------
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.luxurySurface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        elevation: 8,
      ),

      // ---------------- DIALOG ----------------
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.luxurySurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 10,
      ),

      dividerColor: AppColors.lightBorder,

      // ---------------- INPUTS ----------------
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.offWhite,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.luxuryAccent,
            width: 1.6,
          ),
        ),
      ),

      // ---------------- BUTTONS ----------------
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.luxuryAccent,
          foregroundColor: AppColors.espresso,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      // ---------------- TYPOGRAPHY ----------------
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        base.textTheme,
      ).copyWith(
        displayLarge: base.textTheme.displayLarge?.copyWith(
          color: AppColors.luxuryText,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: base.textTheme.displayMedium?.copyWith(
          color: AppColors.luxuryText,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: base.textTheme.titleLarge?.copyWith(
          color: AppColors.luxuryText,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: base.textTheme.bodyLarge?.copyWith(
          color: AppColors.luxuryText,
        ),
        bodyMedium: base.textTheme.bodyMedium?.copyWith(
          color: AppColors.luxuryMuted,
        ),
        labelMedium: base.textTheme.labelMedium?.copyWith(
          color: AppColors.luxuryMuted,
        ),
      ),

      // ---------------- SWITCH ----------------
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? Colors.white
              : AppColors.luxuryMuted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? AppColors.luxuryAccent
              : AppColors.lightBorder;
        }),
      ),

      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
    );
  }

  // ---------------- WORDMARK ----------------
  static TextStyle wordmark(double size) => GoogleFonts.playfairDisplay(
    fontSize: size,
    fontWeight: FontWeight.w600,
    color: AppColors.cream,
    letterSpacing: 0.5,
    height: 1.0,
  );

  static TextStyle wordmarkLight(double size) =>
      GoogleFonts.playfairDisplay(
        fontSize: size,
        fontWeight: FontWeight.w600,
        color: AppColors.darkText,
        letterSpacing: 0.5,
        height: 1.0,
      );
}