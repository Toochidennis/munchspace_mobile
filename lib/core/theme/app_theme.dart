import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Base text theme using Google Fonts - Rubik
  static TextTheme get _baseTextTheme => GoogleFonts.rubikTextTheme();

  // ============================================================================
  // Light Theme Configuration
  // ============================================================================

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: AppColors.lightColorScheme,

      // Primary colors
      primaryColor: AppColors.green,
      primaryColorLight: AppColors.green,
      primaryColorDark: AppColors.green,

      // Background colors
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.surface,
      cardColor: AppColors.surfaceContainer,

      // Divider and disabled colors
      dividerColor: AppColors.divider,
      disabledColor: AppColors.disabled,

      // Text theme with Rubik font as default
      textTheme: GoogleFonts.rubikTextTheme(_lightTextTheme),
      primaryTextTheme: GoogleFonts.rubikTextTheme(_lightPrimaryTextTheme),

      // App Bar Theme with system overlay
      appBarTheme: _lightAppBarTheme.copyWith(
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: AppColors.background,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColors.surface,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),

      // Other theme components
      bottomNavigationBarTheme: _lightBottomNavigationBarTheme,
      navigationBarTheme: _lightNavigationBarTheme,
      elevatedButtonTheme: _lightElevatedButtonTheme,
      textButtonTheme: _lightTextButtonTheme,
      outlinedButtonTheme: _lightOutlinedButtonTheme,
      iconButtonTheme: _lightIconButtonTheme,
      floatingActionButtonTheme: _lightFabTheme,
      inputDecorationTheme: _lightInputDecorationTheme,
      snackBarTheme: _lightSnackBarTheme,
      dialogTheme: DialogThemeData(backgroundColor: AppColors.surface),
    );
  }

  // ============================================================================
  // Dark Theme Configuration
  // ============================================================================

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: AppColors.darkColorScheme,

      // Primary colors
      primaryColor: AppColors.green,
      primaryColorLight: AppColors.green,
      primaryColorDark: AppColors.green,

      // Background colors
      scaffoldBackgroundColor: AppColors.backgroundDark,
      canvasColor: AppColors.surfaceDark,
      cardColor: AppColors.surfaceContainerDark,

      // Divider and disabled colors
      dividerColor: AppColors.dividerDark,
      disabledColor: AppColors.disabled,

      // Text theme with Rubik font as default
      textTheme: GoogleFonts.rubikTextTheme(_darkTextTheme),
      primaryTextTheme: GoogleFonts.rubikTextTheme(_darkPrimaryTextTheme),

      // App Bar Theme with system overlay
      appBarTheme: _darkAppBarTheme.copyWith(
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: AppColors.backgroundDark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.surfaceDark,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),

      // Other theme components
      bottomNavigationBarTheme: _darkBottomNavigationBarTheme,
      navigationBarTheme: _darkNavigationBarTheme,
      elevatedButtonTheme: _darkElevatedButtonTheme,
      textButtonTheme: _darkTextButtonTheme,
      outlinedButtonTheme: _darkOutlinedButtonTheme,
      iconButtonTheme: _darkIconButtonTheme,
      floatingActionButtonTheme: _darkFabTheme,
      inputDecorationTheme: _darkInputDecorationTheme,
      snackBarTheme: _darkSnackBarTheme,
      dialogTheme: DialogThemeData(backgroundColor: AppColors.surfaceDark),
    );
  }

  // ============================================================================
  // Light Text Themes
  // ============================================================================

  static TextTheme get _lightTextTheme => _baseTextTheme.copyWith(
    displayLarge: _baseTextTheme.displayLarge?.copyWith(
      color: AppColors.textPrimary,
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
    ),
    displayMedium: _baseTextTheme.displayMedium?.copyWith(
      color: AppColors.textPrimary,
      fontSize: 45,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: _baseTextTheme.displaySmall?.copyWith(
      color: AppColors.textPrimary,
      fontSize: 36,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: _baseTextTheme.headlineLarge?.copyWith(
      color: AppColors.textPrimary,
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: _baseTextTheme.headlineMedium?.copyWith(
      color: AppColors.textPrimary,
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: _baseTextTheme.headlineSmall?.copyWith(
      color: AppColors.textPrimary,
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: _baseTextTheme.titleLarge?.copyWith(
      color: AppColors.textPrimary,
      fontSize: 22,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: _baseTextTheme.titleMedium?.copyWith(
      color: AppColors.textPrimary,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    titleSmall: _baseTextTheme.titleSmall?.copyWith(
      color: AppColors.textPrimary,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyLarge: _baseTextTheme.bodyLarge?.copyWith(
      color: AppColors.textPrimary,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyMedium: _baseTextTheme.bodyMedium?.copyWith(
      color: AppColors.textSecondary,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    bodySmall: _baseTextTheme.bodySmall?.copyWith(
      color: AppColors.textTertiary,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    labelLarge: _baseTextTheme.labelLarge?.copyWith(
      color: AppColors.textPrimary,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    labelMedium: _baseTextTheme.labelMedium?.copyWith(
      color: AppColors.textSecondary,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
    labelSmall: _baseTextTheme.labelSmall?.copyWith(
      color: AppColors.textTertiary,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  );

  static TextTheme get _lightPrimaryTextTheme => _lightTextTheme.apply(
    bodyColor: AppColors.white,
    displayColor: AppColors.white,
  );

  // ============================================================================
  // Dark Text Themes
  // ============================================================================

  static TextTheme get _darkTextTheme => _lightTextTheme.apply(
    bodyColor: AppColors.textOnDark,
    displayColor: AppColors.textOnDark,
  );

  static TextTheme get _darkPrimaryTextTheme => _darkTextTheme.apply(
    bodyColor: AppColors.white,
    displayColor: AppColors.white,
  );

  // ============================================================================
  // App Bar Themes
  // ============================================================================

  static AppBarTheme get _lightAppBarTheme => AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 1,
    backgroundColor: AppColors.green,
    foregroundColor: AppColors.textPrimary,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: GoogleFonts.rubik(
      color: AppColors.textPrimary,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),
    actionsIconTheme: const IconThemeData(
      color: AppColors.textPrimary,
      size: 24,
    ),
    centerTitle: false,
    toolbarHeight: 56,
  );

  static AppBarTheme get _darkAppBarTheme => _lightAppBarTheme.copyWith(
    backgroundColor: AppColors.surfaceDark,
    foregroundColor: AppColors.textOnDark,
    titleTextStyle: GoogleFonts.rubik(
      color: AppColors.textOnDark,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: const IconThemeData(color: AppColors.textOnDark, size: 24),
    actionsIconTheme: const IconThemeData(
      color: AppColors.textOnDark,
      size: 24,
    ),
  );

  // ============================================================================
  // Bottom Navigation Bar Themes
  // ============================================================================

  static BottomNavigationBarThemeData get _lightBottomNavigationBarTheme =>
      BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.green,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: _baseTextTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: _baseTextTheme.labelSmall,
      );

  static BottomNavigationBarThemeData get _darkBottomNavigationBarTheme =>
      _lightBottomNavigationBarTheme.copyWith(
        backgroundColor: AppColors.surfaceDark,
        unselectedItemColor: AppColors.textOnDark,
      );

  // ============================================================================
  // Navigation Bar Themes
  // ============================================================================

  static NavigationBarThemeData get _lightNavigationBarTheme =>
      NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.indicatorContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _baseTextTheme.labelSmall?.copyWith(
              color: AppColors.green,
              fontWeight: FontWeight.w600,
            );
          }
          return _baseTextTheme.labelSmall?.copyWith(
            color: AppColors.textSecondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.green, size: 24);
          }
          return const IconThemeData(color: AppColors.textSecondary, size: 24);
        }),
      );

  static NavigationBarThemeData get _darkNavigationBarTheme =>
      _lightNavigationBarTheme.copyWith(backgroundColor: AppColors.surfaceDark);

  // ============================================================================
  // Button Themes
  // ============================================================================

  static ElevatedButtonThemeData get _lightElevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orange,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.disabledContainer,
          disabledForegroundColor: AppColors.disabled,
          elevation: 1,
          shadowColor: AppColors.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          fixedSize: const Size.fromHeight(52),
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: _baseTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  static ElevatedButtonThemeData get _darkElevatedButtonTheme =>
      _lightElevatedButtonTheme;

  static TextButtonThemeData get _lightTextButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.green,
      disabledForegroundColor: AppColors.disabled,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      textStyle: _baseTextTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static TextButtonThemeData get _darkTextButtonTheme => _lightTextButtonTheme;

  static OutlinedButtonThemeData get _lightOutlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.green,
          disabledForegroundColor: AppColors.disabled,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: _baseTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  static OutlinedButtonThemeData get _darkOutlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.green,
          disabledForegroundColor: AppColors.disabled,
          side: const BorderSide(color: AppColors.borderDark),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: _baseTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  static IconButtonThemeData get _lightIconButtonTheme => IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: AppColors.textPrimary,
      disabledForegroundColor: AppColors.disabled,
      iconSize: 24,
    ),
  );

  static IconButtonThemeData get _darkIconButtonTheme => IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: AppColors.textOnDark,
      disabledForegroundColor: AppColors.disabled,
      iconSize: 24,
    ),
  );

  // ============================================================================
  // Floating Action Button Themes
  // ============================================================================

  static FloatingActionButtonThemeData get _lightFabTheme =>
      FloatingActionButtonThemeData(
        backgroundColor: AppColors.green,
        foregroundColor: AppColors.white,
        elevation: 6,
        focusElevation: 8,
        hoverElevation: 8,
        highlightElevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      );

  static FloatingActionButtonThemeData get _darkFabTheme => _lightFabTheme;

  // ============================================================================
  // Input Decoration Themes
  // ============================================================================

  static InputDecorationTheme get _lightInputDecorationTheme =>
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainer,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintStyle: _baseTextTheme.bodyMedium?.copyWith(
          color: AppColors.textTertiary,
        ),
        labelStyle: _baseTextTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
        errorStyle: _baseTextTheme.bodySmall?.copyWith(color: AppColors.red),
      );

  static InputDecorationTheme get _darkInputDecorationTheme =>
      InputDecorationTheme(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintStyle: _baseTextTheme.bodyMedium?.copyWith(
          color: AppColors.textTertiary,
        ),
        labelStyle: _baseTextTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
        errorStyle: _baseTextTheme.bodySmall?.copyWith(color: AppColors.red),
      );

  // ============================================================================
  // Snack Bar Themes
  // ============================================================================

  static SnackBarThemeData get _lightSnackBarTheme => SnackBarThemeData(
    backgroundColor: AppColors.surfaceDark,
    contentTextStyle: _baseTextTheme.bodyMedium?.copyWith(
      color: AppColors.textOnDark,
    ),
    actionTextColor: AppColors.actionText,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    behavior: SnackBarBehavior.floating,
    elevation: 6,
  );

  static SnackBarThemeData get _darkSnackBarTheme => _lightSnackBarTheme;
}
