import 'package:flutter/material.dart';

/// MunchSpace Color Palette
///
/// Brand Colors:
/// - Green: Used for main actions and primary elements
/// - Orange: Used for secondary actions and highlights
/// - Blue: Used for trust elements and links
/// - Red: Used for errors and alerts
///
/// Text & Neutral:
/// - Black: Primary text on light backgrounds
/// - White: Text on dark backgrounds

class AppColors {
  AppColors._();

  // ============================================================================
  // Primary Brand Named Colors
  // ============================================================================

  /// Primary Green
  /// Used for main actions, primary elements
  static const Color green = Color(0xFF3C7E41);

  /// Primary Orange
  /// Used for secondary actions, highlights
  static const Color orange = Color(0xFFE76A39);

  /// Light Background
  /// Used for light mode backgrounds
  static const Color backgroundLight = Color(0xFFF3FAF3);

  // ============================================================================
  // Accent Colors
  // ============================================================================

  /// Blue Accent
  /// Used for links, trust elements, secondary actions
  static const Color blue = Color(0xFF3A75C4);

  /// Red Accent
  /// Used for errors, warnings, destructive actions
  static const Color red = Color(0xFFC43A3A);

  /// Pink Accent
  /// Used for special highlights, decorative elements
  static const Color pink = Color(0xFFFBE8D9);

  // ============================================================================
  // Basic Colors
  // ============================================================================

  /// Pure white
  static const Color white = Color(0xFFFFFFFF);

  /// Pure black
  static const Color black = Color(0xFF000000);

  // ============================================================================
  // Text Colors - Light Mode
  // ============================================================================

  /// Dark Text - primary text color for light mode
  static const Color textPrimary = Color(0xFF141414);

  /// Secondary text color (slightly lighter)
  static const Color textSecondary = Color(0xFF525252);

  /// Tertiary/disabled text color
  static const Color textTertiary = Color(0xFF858585);

  // ============================================================================
  // Text Colors - Dark Mode
  // ============================================================================

  /// Light Text - primary text color for dark mode
  static const Color textOnDark = Color(0xFFF5F5F5);

  /// Secondary text on dark (slightly darker)
  static const Color textSecondaryDark = Color(0xFFCCCCCC);

  /// Tertiary text on dark
  static const Color textTertiaryDark = Color(0xFF999999);

  // ============================================================================
  // Background & Surface Colors - Light Mode
  // ============================================================================

  /// Light mode scaffold background
  static const Color background = Color(0xFFFAFAFA);

  /// Light mode surface (cards, dialogs)
  static const Color surface = Color(0xFFFFFFFF);

  /// Light mode surface container (elevated surfaces)
  static const Color surfaceContainer = Color(0xFFF5F5F5);

  // ============================================================================
  // Background & Surface Colors - Dark Mode
  // ============================================================================

  /// Dark mode scaffold background
  static const Color backgroundDark = Color(0xFF1A1A1A);

  /// Dark mode surface (cards, dialogs)
  static const Color surfaceDark = Color(0xFF242424);

  /// Dark mode surface container (elevated surfaces)
  static const Color surfaceContainerDark = Color(0xFF2E2E2E);

  // ============================================================================
  // State Colors
  // ============================================================================

  /// Disabled state color
  static const Color disabled = Color(0xFFBDBDBD);

  /// Disabled container background
  static const Color disabledContainer = Color(0xFFE8E8E8);

  /// Success state color
  static const Color success = Color(0xFF4CAF50);

  /// Warning state color
  static const Color warning = Color(0xFFFFC107);

  /// Info state color
  static const Color info = Color(0xFF2196F3);

  /// Container/indicator light color for navigation
  static const Color indicatorContainer = Color(0xFFD5E8D8);

  /// Action text color for snackbars and similar elements
  static const Color actionText = Color(0xFFA8D5AF);

  // ============================================================================
  // Border & Divider Colors
  // ============================================================================

  /// Border color for light mode
  static const Color border = Color(0xFFE0E0E0);

  /// Border color for dark mode
  static const Color borderDark = Color(0xFF3E3E3E);

  /// Divider color for light mode
  static const Color divider = Color(0xFFEBEBEB);

  /// Divider color for dark mode
  static const Color dividerDark = Color(0xFF353535);

  // ============================================================================
  // Shadow & Overlay Colors
  // ============================================================================

  /// Shadow color (typically black with transparency)
  static const Color shadow = Color(0x1A000000);

  /// Overlay color for elevated surfaces
  static const Color overlay = Color(0x0A000000);

  /// Scrim color (dark overlay)
  static const Color scrim = Color(0x00000000);

  // ============================================================================
  // Material 3 ColorScheme - Light
  // ============================================================================

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: green,
    onPrimary: white,
    primaryContainer: Color(0xFFD5E8D8),
    onPrimaryContainer: textPrimary,
    secondary: orange,
    onSecondary: white,
    secondaryContainer: Color(0xFFFFECDC),
    onSecondaryContainer: textPrimary,
    tertiary: blue,
    onTertiary: white,
    tertiaryContainer: Color(0xFFE7F0FF),
    onTertiaryContainer: textPrimary,
    error: red,
    onError: white,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410E0B),
    surface: white,
    onSurface: textPrimary,
    surfaceContainerHighest: Color(0xFFF5F5F5),
    onSurfaceVariant: textSecondary,
    outline: textTertiary,
    outlineVariant: Color(0xFFE0E0E0),
    shadow: Color(0x1A000000),
    scrim: Color(0x00000000),
    inverseSurface: Color(0xFF303030),
    onInverseSurface: Color(0xFFF6F0ED),
    inversePrimary: Color(0xFFA8D5AF),
    surfaceTint: green,
  );

  // ============================================================================
  // Material 3 ColorScheme - Dark
  // ============================================================================

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFA8D5AF),
    onPrimary: Color(0xFF2D5E31),
    primaryContainer: Color(0xFF2D5E31),
    onPrimaryContainer: Color(0xFFA8D5AF),
    secondary: Color(0xFFF5B88D),
    onSecondary: Color(0xFFB35429),
    secondaryContainer: Color(0xFFB35429),
    onSecondaryContainer: Color(0xFFF5B88D),
    tertiary: Color(0xFF8CAEE8),
    onTertiary: Color(0xFF2A5BA8),
    tertiaryContainer: Color(0xFF2A5BA8),
    onTertiaryContainer: Color(0xFF8CAEE8),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF242424),
    onSurface: Color(0xFFF5F5F5),
    surfaceContainerHighest: Color(0xFF2E2E2E),
    onSurfaceVariant: Color(0xFFCCCCCC),
    outline: Color(0xFF999999),
    outlineVariant: Color(0xFF3E3E3E),
    shadow: Color(0x1A000000),
    scrim: Color(0x00000000),
    inverseSurface: Color(0xFFF6F0ED),
    onInverseSurface: Color(0xFF303030),
    inversePrimary: green,
    surfaceTint: Color(0xFFA8D5AF),
  );

  // ============================================================================
  // Gradient Colors
  // ============================================================================

  /// Primary gradient for backgrounds
  static LinearGradient get primaryGradient => const LinearGradient(
    colors: [green, Color(0xFFA8D5AF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Secondary gradient for highlights
  static LinearGradient get secondaryGradient => const LinearGradient(
    colors: [orange, Color(0xFFF5B88D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Accent gradient for buttons
  static LinearGradient get accentGradient => const LinearGradient(
    colors: [blue, Color(0xFF8CAEE8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
