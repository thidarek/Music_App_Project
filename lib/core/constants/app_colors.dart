import 'package:flutter/material.dart';

class AppColors {
  // BACKGROUND COLORS
  static  Color primaryBackground = Color(0xFF121212);
  static  Color secondaryBackground = Color(0xFF1E1E1E);
  static  Color cardBackground = Color(0xFF2A2A2A);
  static  Color surfaceBackground = Color(0xFF282828);
  static  Color lighterBackground = Color(0xFF333333);
  static  Color searchBarBackground = Color(0xFF3E3E3E);
  
  // GRADIENT COLORS ============
  static  Color gradientStart = Color(0xFF1A1A1A);
  static  Color gradientEnd = Color(0xFF0D0D0D);
  
  static  LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [gradientStart, gradientEnd],
  );
  
  // ============ TEXT COLORS ============
  static  Color primaryText = Color(0xFFFFFFFF);
  static  Color secondaryText = Color(0xFFB3B3B3);
  static  Color mutedText = Color(0xFF808080);
  static  Color hintText = Color(0xFFB3B3B3);

  // ============ ACCENT & ACTION COLORS ============
  static  Color accentGreen = Color(0xFF1ED760);
  static  Color accentGreenDark = Color(0xFF1AA34A);
  static  Color accentBlue = Color(0xFF1A73E8);
  static  Color accentPurple = Color(0xFF9B59B6);

  // ============ BORDER & DIVIDER COLORS ============
  static  Color dividerColor = Color(0xFF535353);
  static  Color borderColor = Color(0xFF404040);

  // ============ BOTTOM NAVIGATION BAR COLORS ============
  static  Color navBarBackground = Color(0xFF121212);
  static  Color navBarActiveIcon = Color(0xFFFFFFFF);
  static  Color navBarInactiveIcon = Color(0xFF808080);

  // ======= BUTTON COLORS ============
  static  Color playButtonColor = Color(0xFF1ED760);
  static  Color buttonDisabled = Color(0xFF535353);

  // ======= OVERLAY & SHADOW COLORS ============
  static  Color shadowColor = Color(0x1A000000);
  static  Color overlayColor = Color(0x80000000);

  // ======= STATUS/INDICATOR COLORS ============
  static  Color successColor = Color(0xFF4CAF50);
  static  Color errorColor = Color(0xFFE74C3C);
  static  Color warningColor = Color(0xFFF39C12);
  static  Color infoColor = Color(0xFF3498DB);

  // ======= ARTIST CARD COLORS (For variety) ============
  static  Color artistCard1 = Color(0xFF2C3E50);
  static  Color artistCard2 = Color(0xFF8E44AD);
  static  Color artistCard3 = Color(0xFF27AE60);
  static  Color artistCard4 = Color(0xFFD35400);
  static  Color artistCard5 = Color(0xFF2980B9);
  static  Color artistCard6 = Color(0xFFE74C3C);

  // ======= SONG CARD COLORS ============
  static  Color songCard1 = Color(0xFF2A2A2A);
  static  Color songCard2 = Color(0xFF3D3D3D);
  static  Color songCardHover = Color(0xFF404040);

  // ======= TRANSPARENT WITH OPACITY ============
  static  Color transparentWhite = Color(0x1AFFFFFF);
  static  Color transparentBlack = Color(0x1A000000);
  static  Color transparentAccent = Color(0x33D4A373);

  // ======= COMMON THEME COLORS ============
  static  Color white = Color(0xFFFFFFFF);
  static  Color black = Color(0xFF000000);
  static  Color transparent = Color(0x00000000);

  // ======= CUSTOM SHADES ============
  static  Color grey50 = Color(0xFFFAFAFA);
  static  Color grey100 = Color(0xFFF5F5F5);
  static  Color grey200 = Color(0xFFEEEEEE);
  static  Color grey300 = Color(0xFFE0E0E0);
  static  Color grey400 = Color(0xFFBDBDBD);
  static  Color grey500 = Color(0xFF9E9E9E);
  static  Color grey600 = Color(0xFF757575);
  static  Color grey700 = Color(0xFF616161);
  static  Color grey800 = Color(0xFF424242);
  static  Color grey900 = Color(0xFF212121);

  // ======= MATERIAL DESIGN ACCENTS ============
  static  MaterialColor primarySwatch = MaterialColor(
    0xFF1,
    <int, Color>{
      50: Color(0xFFE8F5E9),
      100: Color(0xFFC8E6C9),
      200: Color(0xFFA5D6A7),
      300: Color(0xFF81C784),
      400: Color(0xFF66BB6A),
      500: Color(0xFF1ED760),
      600: Color(0xFF43A047),
      700: Color(0xFF388E3C),
      800: Color(0xFF2E7D32),
      900: Color(0xFF1B5E20),
    },
  );
}

// ============ THEME EXTENSION FOR EASY ACCESS ============
extension AppColorsExtension on BuildContext {
  AppColors get appColors =>  AppColors();
}