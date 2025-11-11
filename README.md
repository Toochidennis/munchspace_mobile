# MunchSpace 🍽️

**MunchSpace** is a modern food delivery application designed specifically for Nigeria. It connects hungry customers with local restaurants, enabling seamless food ordering and delivery experiences.

---

## 📋 Table of Contents

- [About MunchSpace](#about-munchspace)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Development Guidelines](#development-guidelines)
- [Brand Guidelines](#brand-guidelines)

---

## About MunchSpace

MunchSpace is a **Nigerian food delivery platform** that brings the best local restaurants directly to customers' doorsteps. Our mission is to make food ordering simple, fast, and accessible to everyone in Nigeria.

### Core Values
- **Simplicity**: Easy-to-use interface for all users
- **Speed**: Fast order processing and delivery
- **Reliability**: Trusted service from local restaurants
- **Community**: Supporting local businesses

---

## Features

### For Customers
- 🔍 **Browse Restaurants** - Discover local restaurants and cuisines
- 🛒 **Easy Ordering** - Intuitive cart and checkout process
- 💰 **Multiple Payment Methods** - Secure payment options
- 📍 **Real-time Tracking** - Track your order from restaurant to doorstep
- ⭐ **Ratings & Reviews** - Read and leave reviews
- 📱 **Push Notifications** - Get order updates instantly
- ❤️ **Favorites** - Save your favorite restaurants and meals
- 🎯 **Smart Recommendations** - Personalized meal suggestions

### For Restaurants
- 📊 **Dashboard** - Manage orders and inventory
- 🕐 **Operating Hours** - Set availability and delivery zones
- 🍲 **Menu Management** - Update dishes and prices easily
- 📈 **Analytics** - Track sales and popular items
- 💳 **Earnings** - Transparent payment and settlement

---

## Tech Stack

### Frontend
- **Framework**: Flutter 3.x+
- **State Management**: Riverpod (provider-based, reactive)
- **HTTP Client**: Dio (with interceptors)
- **Local Database**: Hive (for offline-first capability)
- **Secure Storage**: flutter_secure_storage (for credentials)
- **UI/UX**:
  - google_fonts (Rubik typography)
  - flutter_screenutil (responsive design)
  - Material Design 3

### Backend (Referenced)
- API-based architecture
- RESTful endpoints
- Authentication via tokens

### Development Tools
- build_runner (code generation)
- hive_generator (database models)
- Dart Analyzer (static analysis)

---

## Architecture

MunchSpace follows **Clean Architecture** principles with three distinct layers:

### 🏗️ Clean Architecture Layers

```
Feature
├── Presentation Layer
│   ├── Pages (UI screens)
│   ├── Widgets (reusable components)
│   └── State Management (Riverpod providers)
│
├── Domain Layer
│   ├── Entities (business models)
│   ├── Repositories (abstract interfaces)
│   └── Use Cases (business logic)
│
└── Data Layer
    ├── Models (JSON serialization)
    ├── Data Sources (API, local DB)
    └── Repository Implementations
```

### Key Principles

- **Separation of Concerns**: Each layer has a specific responsibility
- **Testability**: Dependencies are injected and mockable
- **Reusability**: Business logic is independent of framework
- **Scalability**: Easy to add new features without affecting others

---

## Getting Started

### Prerequisites

- Flutter SDK 3.x+ ([Install Flutter](https://docs.flutter.dev/get-started/install))
- Dart 3.x+
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Toochidennis/munchspace_mobile.git
   cd munchspace_mobile
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code (for Hive models)**
   ```bash
   flutter pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Available Platforms
- ✅ Android (primary target)
- ✅ iOS (supported)

---

## Project Structure

```
lib/
├── core/
│   ├── theme/           # App theming (colors, typography, Material 3)
│   │   ├── app_colors.dart
│   │   ├── app_theme.dart
│   │   └── theme_extensions.dart
│   ├── utils/           # Utility functions
│   │   └── responsive.dart
│   └── constants.dart   # App-wide constants
│
├── features/            # Feature modules (each with presentation/domain/data)
│   ├── home/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   ├── widgets/
│   │   │   └── providers/      # Riverpod providers
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── data/
│   │       ├── models/
│   │       ├── datasources/
│   │       └── repositories/
│   ├── auth/
│   ├── restaurants/
│   ├── orders/
│   └── [other features...]
│
└── main.dart            # App entry point
```

### Core Module
- **theme/**: Material Design 3 theming with Rubik font
- **utils/**: Responsive design utilities using flutter_screenutil
- **constants.dart**: App-wide constants (API endpoints, timeouts, etc.)

### Features Module
Each feature is self-contained with its own presentation, domain, and data layers. This ensures:
- Features can be developed independently
- Easy to test
- Simple to add/remove features
- No cross-feature dependencies (except through core)

---

## Development Guidelines

### Adding a New Feature

1. **Create feature directory structure**
   ```bash
   mkdir -p lib/features/[feature_name]/{presentation,domain,data}
   ```

2. **Follow the layer pattern**
   - **Domain**: Define entities and repository interfaces (business rules)
   - **Data**: Implement repositories, models, and data sources
   - **Presentation**: Create pages/widgets and Riverpod providers for state

3. **Use Riverpod for State Management**
   ```dart
   // In lib/features/[feature]/presentation/providers/
   final getItemsProvider = FutureProvider<List<Item>>((ref) async {
     final repository = ref.watch(repositoryProvider);
     return repository.getItems();
   });
   ```

4. **Write Business Logic in Use Cases**
   ```dart
   // In lib/features/[feature]/domain/usecases/
   class GetItemsUseCase {
     final Repository repository;
     Future<List<Item>> call() => repository.getItems();
   }
   ```

5. **Handle Errors Gracefully**
   - Use try-catch blocks in repositories
   - Provide user-friendly error messages
   - Log errors for debugging

### Code Style
- Follow Dart conventions
- Use meaningful variable/function names
- Add documentation comments for public APIs
- Keep functions small and focused
- Use const constructors where possible

### Testing
- Write unit tests for use cases
- Write widget tests for UI components
- Mock repositories in tests
- Aim for high coverage in critical paths

---

## Brand Guidelines

### Color Palette

MunchSpace uses a carefully selected color palette that reflects our brand identity:

| Color | Value | Usage |
|-------|-------|-------|
| **Green** | `#3C7E41` | Primary actions, brand identity |
| **Orange** | `#E76A39` | Secondary actions, highlights |
| **Blue** | `#3A75C4` | Links, trust elements |
| **Red** | `#C43A3A` | Errors, alerts, destructive actions |
| **White** | `#FFFFFF` | Backgrounds, text on dark |
| **Black** | `#000000` | Primary text, dark backgrounds |

All colors are defined in `lib/core/theme/app_colors.dart` and should **ONLY** be used from there.

### Typography

- **Font Family**: Rubik (via Google Fonts)
- **Default Weights**: Regular (400), Medium (500), Semi-Bold (600), Bold (700)
- **Responsive Sizing**: Uses flutter_screenutil for all font sizes

### UI Components

- **Material Design 3** compliance
- **Elevation**: Used for depth and hierarchy
- **Rounded Corners**: 8px for cards, 24px for buttons
- **Responsive Design**: Adapts to all screen sizes

---

## Dependencies

### Core Dependencies
```yaml
dependencies:
  flutter_riverpod: ^2.4.0      # State management
  riverpod: ^2.4.0               # Core provider
  dio: ^5.3.1                    # HTTP client
  hive: ^2.0.0                   # Local database
  hive_flutter: ^1.1.0
  flutter_secure_storage: ^9.0.0 # Secure storage
  google_fonts: ^6.1.0           # Typography
  flutter_screenutil: ^5.9.0     # Responsive design
  connectivity_plus: ^5.0.1      # Network detection
  intl: ^0.19.0                  # Internationalization
```

### Dev Dependencies
```yaml
dev_dependencies:
  build_runner: ^2.4.0
  hive_generator: ^2.0.0
```

---

## Troubleshooting

### Common Issues

**Issue**: Hive models not generating
```bash
# Solution: Run build_runner
flutter pub run build_runner build --delete-conflicting-outputs
```

**Issue**: Responsive design not working
```dart
// Ensure ScreenUtilInit is wrapping MaterialApp in main.dart
ScreenUtilInit(
  designSize: const Size(393, 852),
  builder: (context, child) => MaterialApp(...),
)
```

**Issue**: Riverpod provider not updating
```dart
// Check that you're watching the provider correctly
final data = ref.watch(myProvider); // Use watch for UI
final data = ref.read(myProvider); // Use read for imperative code
```

---

## Contributing

1. Create a feature branch: `git checkout -b feature/your-feature`
2. Follow the architecture guidelines
3. Write tests for new code
4. Ensure no linting errors: `dart analyze`
5. Submit a pull request with clear description

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Contact & Support

For questions or support, please contact the development team or open an issue on GitHub.

---

**Last Updated**: November 2024  
**App Version**: 1.0.0-alpha  
**Maintainers**: MunchSpace Development Team
