/// App-wide constants
class AppConstants {
  AppConstants._();

  // ============================================================================
  // App Information
  // ============================================================================

  static const String appName = 'MunchSpace';
  static const String appVersion = '1.0.0';
  static const String appBuild = '1';

  // ============================================================================
  // API Configuration
  // ============================================================================

  static const String apiBaseUrl = 'https://api.munchspace.app/v1';
  static const int apiTimeoutDuration = 30; // seconds
  static const int maxRetries = 3;

  // ============================================================================
  // Pagination
  // ============================================================================

  static const int defaultPageSize = 20;
  static const int initialPage = 1;

  // ============================================================================
  // Cache Configuration
  // ============================================================================

  static const String cacheKeyPrefix = 'munchspace_';
  static const int cacheExpirationDays = 7;

  // ============================================================================
  // Shared Preferences Keys
  // ============================================================================

  static const String keyIsLoggedIn = 'isLoggedIn';
  static const String keyUserToken = 'userToken';
  static const String keyRefreshToken = 'refreshToken';
  static const String keyUserId = 'userId';
  static const String keyUserEmail = 'userEmail';
  static const String keyThemeMode = 'themeMode';
  static const String keyLanguage = 'language';

  // ============================================================================
  // Hive Boxes
  // ============================================================================

  static const String hiveBoxUser = 'user_box';
  static const String hiveBoxCache = 'cache_box';
  static const String hiveBoxPreferences = 'preferences_box';

  // ============================================================================
  // Error Messages
  // ============================================================================

  static const String errorNetworkFailure = 'Network connection failed';
  static const String errorServerFailure = 'Server error occurred';
  static const String errorCacheFailure = 'Cache error occurred';
  static const String errorUnknown = 'Unknown error occurred';
  static const String errorInvalidInput = 'Invalid input provided';
  static const String errorNotFound = 'Resource not found';
  static const String errorUnauthorized = 'Unauthorized access';
  static const String errorForbidden = 'Access forbidden';

  // ============================================================================
  // Success Messages
  // ============================================================================

  static const String messageSuccess = 'Operation successful';
  static const String messageLoginSuccess = 'Login successful';
  static const String messageLogoutSuccess = 'Logged out successfully';
  static const String messageDataLoaded = 'Data loaded successfully';

  // ============================================================================
  // Validation
  // ============================================================================

  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 128;
  static const int minNameLength = 2;
  static const int maxNameLength = 100;
  static const int minPhoneLength = 10;
  static const int maxPhoneLength = 15;

  // ============================================================================
  // Durations
  // ============================================================================

  static const Duration snackBarDuration = Duration(seconds: 2);
  static const Duration longSnackBarDuration = Duration(seconds: 4);
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration debounceSearchDuration = Duration(milliseconds: 500);

  // ============================================================================
  // UI Configuration
  // ============================================================================

  static const int maxSearchHistoryItems = 10;
  static const int imageCacheSize = 50 * 1024 * 1024; // 50 MB

  // ============================================================================
  // Feature Flags
  // ============================================================================

  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enableOfflineMode = true;
}
