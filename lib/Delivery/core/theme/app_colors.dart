import 'package:flutter/material.dart';

/// Savora brand palette — warm, premium, appetite-driven.
class AppColors {
  AppColors._();
  static const Color lightCardDark = Color(0xFF1A1510); // espresso soft
  static const Color lightCardDark2 = Color(0xFF221B16); // hover / elevated
  static const Color lightCardBorderDark = Color(0x33221B16);
  // --- Base (deep espresso backdrop) ---
  // Kept these dark and rich for high contrast.
  static const Color espresso = Color(0xFF120E0A); // Slightly deeper
  static const Color espressoSoft = Color(0xFF1A1510);
  static const Color charcoal = Color(0xFF221E19);
  static const Color cardDarkSoft = Color(0xFF241C16); // main card
  static const Color cardDarkSoft2 = Color(0xFF2B221B); // hover/elevated
  static const Color cardStroke = Color(0x33F2E9D8); // warm subtle border
  // --- Warm accents ---
  // Muted the vibrancy just slightly to look more like natural, high-end ingredients.
  static const Color saffron = Color(0xFFE59C24); // Richer, less neon yellow
  static const Color deepSaffron = Color(0xFF2D1F14);
  static const Color gold = Color(0xFFE8B62C); // Deeper, more authentic gold
  static const Color amber = Color(0xFFB36500); // Slightly darker for better contrast
  static const Color terracotta = Color(0xFFBC5328); // More "burnt" and natural
  static const Color ember = Color(0xFFB84215);
  static const Color clay = Color(0xFF2C1810);

  // --- Neutrals / text ---
  static const Color cream = Color(0xFFF2E9D8); // Warmer, more buttery
  static const Color creamDim = Color(0xFFD4C8B8);
  static const Color muted = Color(0xFF7A7065); // Darkened slightly for readability
  static const Color textOnDarkCard = Color(0xFFF3EBDD); // primary text
  static const Color textOnDarkCardMuted = Color(0xFFB8ADA0); // secondary text
  // --- White theme ---
  // Premium apps rarely use pure #FFFFFF everywhere. We rely on creamy off-whites.
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF4F0E8); // More distinct "card" background
  static const Color warmWhite = Color(0xFFF9F7F2); // Excellent scaffold background
  static const Color darkText = Color(0xFF140F0C); // Almost black, warm undertone
  static const Color softText = Color(0xFF5A5249); // Darkened for accessibility/WCAG compliance
  static const Color lightBorder = Color(0xFFE2DDD5); // Slightly more visible border
  static const Color lightGlass = Color(0x0A140F0C);
  static const Color luxuryBackground = Color(0xFFF1ECE3);
  static const Color luxurySurface = Color(0xFFE7DED1);
  static const Color luxuryCard = Color(0xFFDDD1C0);

  static const Color luxuryAccent = Color(0xFFE5A528);
  static const Color luxuryAccentDark = Color(0xFFB87918);

  static const Color luxuryText = Color(0xFF1C1712);
  static const Color luxuryMuted = Color(0xFF675F55);
  // --- Glass surfaces ---
  static const Color glass = Color(0x14FFFFFF);
  static const Color glassStrong = Color(0x1FFFFFFF);
  static const Color glassBorder = Color(0x26FFFFFF);

  static const LinearGradient accentGradient = LinearGradient(
    colors: [saffron, terracotta],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}