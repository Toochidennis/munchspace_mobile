import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Extension methods for easy access to theme colors and properties
/// Usage: context.textPrimary, context.isDarkMode, etc.
extension ThemeExtension on BuildContext {
  /// Get the current brightness (light/dark)
  Brightness get brightness => Theme.of(this).brightness;

  /// Check if dark mode is enabled
  bool get isDarkMode => brightness == Brightness.dark;

  // ============================================================================
  // Text Colors
  // ============================================================================

  /// Get text primary color based on current theme
  Color get textPrimary =>
      isDarkMode ? AppColors.textOnDark : AppColors.textPrimary;

  /// Get text secondary color based on current theme
  Color get textSecondary =>
      isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary;

  /// Get text tertiary color based on current theme
  Color get textTertiary =>
      isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiary;

  // ============================================================================
  // Background Colors
  // ============================================================================

  /// Get background color based on current theme
  Color get background =>
      isDarkMode ? AppColors.backgroundDark : AppColors.background;

  /// Get surface color based on current theme
  Color get surface => isDarkMode ? AppColors.surfaceDark : AppColors.surface;

  /// Get surface container color based on current theme
  Color get surfaceContainer =>
      isDarkMode ? AppColors.surfaceContainerDark : AppColors.surfaceContainer;

  // ============================================================================
  // Primary Colors
  // ============================================================================

  /// Get primary color (green)
  Color get primary => AppColors.green;

  /// Get on primary (text on primary background)
  Color get onPrimary => AppColors.white;

  // ============================================================================
  // Secondary Colors
  // ============================================================================

  /// Get secondary color (orange)
  Color get secondary => AppColors.orange;

  /// Get on secondary (text on secondary background)
  Color get onSecondary => AppColors.white;

  // ============================================================================
  // Accent Colors
  // ============================================================================

  /// Get accent color (blue)
  Color get accent => AppColors.blue;

  /// Get on accent (text on accent background)
  Color get onAccent => AppColors.white;

  // ============================================================================
  // State Colors
  // ============================================================================

  /// Get error color
  Color get error => AppColors.red;

  /// Get success color
  Color get success => AppColors.success;

  /// Get warning color
  Color get warning => AppColors.warning;

  /// Get info color
  Color get info => AppColors.info;

  /// Get disabled color
  Color get disabled => AppColors.disabled;

  /// Get disabled container color
  Color get disabledContainer => AppColors.disabledContainer;

  // ============================================================================
  // Border & Divider Colors
  // ============================================================================

  /// Get border color based on current theme
  Color get border => isDarkMode ? AppColors.borderDark : AppColors.border;

  /// Get divider color based on current theme
  Color get divider => isDarkMode ? AppColors.dividerDark : AppColors.divider;

  // ============================================================================
  // Shadow & Overlay
  // ============================================================================

  /// Get shadow color
  Color get shadow => AppColors.shadow;

  /// Get overlay color
  Color get overlay => AppColors.overlay;

  /// Get scrim color
  Color get scrim => AppColors.scrim;

  // ============================================================================
  // Theme Data Getters
  // ============================================================================

  /// Get current color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Get current text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get display large text style
  TextStyle? get displayLarge => textTheme.displayLarge;

  /// Get display medium text style
  TextStyle? get displayMedium => textTheme.displayMedium;

  /// Get display small text style
  TextStyle? get displaySmall => textTheme.displaySmall;

  /// Get headline large text style
  TextStyle? get headlineLarge => textTheme.headlineLarge;

  /// Get headline medium text style
  TextStyle? get headlineMedium => textTheme.headlineMedium;

  /// Get headline small text style
  TextStyle? get headlineSmall => textTheme.headlineSmall;

  /// Get title large text style
  TextStyle? get titleLarge => textTheme.titleLarge;

  /// Get title medium text style
  TextStyle? get titleMedium => textTheme.titleMedium;

  /// Get title small text style
  TextStyle? get titleSmall => textTheme.titleSmall;

  /// Get body large text style
  TextStyle? get bodyLarge => textTheme.bodyLarge;

  /// Get body medium text style
  TextStyle? get bodyMedium => textTheme.bodyMedium;

  /// Get body small text style
  TextStyle? get bodySmall => textTheme.bodySmall;

  /// Get label large text style
  TextStyle? get labelLarge => textTheme.labelLarge;

  /// Get label medium text style
  TextStyle? get labelMedium => textTheme.labelMedium;

  /// Get label small text style
  TextStyle? get labelSmall => textTheme.labelSmall;

  // ============================================================================
  // Utility Methods
  // ============================================================================

  /// Get the opposite brightness (light -> dark, dark -> light)
  Brightness get oppositeBrightness =>
      isDarkMode ? Brightness.light : Brightness.dark;

  /// Check if using a light theme
  bool get isLightMode => !isDarkMode;

  /// Get contrast color (white for dark, black for light)
  Color get contrastColor => isDarkMode ? Colors.white : Colors.black;
}

/// Extension for theme-aware dialog and bottom sheet styling
extension DialogThemeExtension on BuildContext {
  /// Show a themed dialog
  Future<T?> showThemedDialog<T>({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: builder,
    );
  }

  /// Show a themed bottom sheet
  Future<T?> showThemedBottomSheet<T>({
    required WidgetBuilder builder,
    bool isScrollControlled = false,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      builder: builder,
      backgroundColor: surface,
    );
  }
}

/// Extension for theme-aware snackbar styling
extension SnackBarThemeExtension on BuildContext {
  /// Show a success snackbar
  void showSuccessSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: bodyMedium?.copyWith(color: AppColors.textOnDark),
        ),
        backgroundColor: success,
        duration: duration,
      ),
    );
  }

  /// Show an error snackbar
  void showErrorSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: bodyMedium?.copyWith(color: AppColors.textOnDark),
        ),
        backgroundColor: error,
        duration: duration,
      ),
    );
  }

  /// Show a warning snackbar
  void showWarningSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: bodyMedium?.copyWith(color: Colors.black),
        ),
        backgroundColor: warning,
        duration: duration,
      ),
    );
  }

  /// Show an info snackbar
  void showInfoSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: bodyMedium?.copyWith(color: AppColors.textOnDark),
        ),
        backgroundColor: info,
        duration: duration,
      ),
    );
  }
}
