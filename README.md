🟦 lajvard — لاژورد
A premium, multi-platform Flutter weather app inspired by Lapis Lazuli — the deep blue gemstone.

Screenshots placeholder — will be added in final polish step

✨ Features
🌤 Real-time weather via Open-Meteo API (free, no API key)
🌍 Global coverage with Iran-first strategy
🌙 Dark & Light mode with instant switching
🇮🇷 Full Persian (Farsi) support — RTL, Jalali dates, Persian digits
🇺🇸 Full English support — LTR, Gregorian dates, Western digits
🎨 Lapis Lazuli design — glassmorphism, smooth gradients, curved shapes
📱 Adaptive layout — phone, tablet, foldable
🔄 Dual flavor — iran (Cafe Bazaar/Myket) & global (Google Play/App Store)
🏗 Clean Architecture — scalable, testable, maintainable
🧩 Fully modular — every module is copy-paste reusable

🏛 Architecture
┌─────────────────────────────────────────┐
│ PRESENTATION │
│ Screens → Widgets → Providers │
│ (Riverpod + GoRouter) │
├─────────────────────────────────────────┤
│ DOMAIN │
│ Entities → Repository Interfaces │
│ → Use Cases │
├─────────────────────────────────────────┤
│ DATA │
│ Models → Data Sources → Repositories │
│ (Adapter Pattern) │
├─────────────────────────────────────────┤
│ CORE / SHARED │
│ Color · Typography · Theme · Network │
│ Cache · Connectivity · Settings · L10n │
│ Responsive · Error · Logger · Flavor │
│ Ads · Widget · Shimmer · Glass · Anim │
└─────────────────────────────────────────┘

### Design Patterns Used

| Pattern    | Where                                    |
| ---------- | ---------------------------------------- |
| Singleton  | Global services (Logger, Connectivity)   |
| Builder    | Locale-aware widgets, theme construction |
| Factory    | Model/data source creation               |
| Repository | Data abstraction layer                   |
| Adapter    | API response → domain models             |
| Observer   | Connectivity, theme changes              |
| Strategy   | Temp unit, locale, flavor switching      |
| Facade     | Weather data assembly                    |

---

## 🛠 Tech Stack

| Category         | Technology                  |
| ---------------- | --------------------------- |
| Framework        | Flutter 3.44.x              |
| Language         | Dart 3.8.x                  |
| State Management | flutter_riverpod 3.3.x      |
| Routing          | go_router 17.3.x            |
| Networking       | dio 5.10.x                  |
| Local Storage    | shared_preferences 2.5.x    |
| Location         | geolocator 14.0.x           |
| i18n             | intl 0.20.x (built-in l10n) |
| Loading          | shimmer 3.0.x               |

---

## 📁 Folder Structure

lajvard/
├── assets/
│ ├── logo/
│ ├── fonts/
│ └── icons/
├── docs/
├── lib/
│ ├── core/ # Shared modules (all reusable)
│ │ ├── color/ # Lapis Lazuli color palette
│ │ ├── typography/ # Font management
│ │ ├── theme/ # Material 3 theming
│ │ ├── error/ # Exceptions, failures, logger
│ │ ├── localization/ # L10n setup & utilities
│ │ ├── network/ # HTTP client module
│ │ ├── cache/ # Local cache module
│ │ ├── connectivity/ # Connectivity observer
│ │ ├── settings/ # App settings module
│ │ ├── responsive/ # Breakpoints & adaptive layout
│ │ ├── ads/ # Ad placeholder module
│ │ ├── widget_placeholder/ # Home screen widget placeholder
│ │ ├── flavor/ # Dual flavor configuration
│ │ ├── glassmorphism/ # Frosted glass UI module
│ │ ├── animation/ # Reusable animation module
│ │ └── shimmer/ # Shimmer loading module
│ ├── features/
│ │ ├── weather/
│ │ │ ├── domain/ # Entities, repos, use cases
│ │ │ ├── data/ # Models, data sources, repo impl
│ │ │ └── presentation/ # Screens, widgets, providers
│ │ ├── location/
│ │ │ ├── domain/
│ │ │ ├── data/
│ │ │ └── presentation/
│ │ └── settings/
│ │ ├── domain/
│ │ ├── data/
│ │ └── presentation/
│ ├── app.dart # MaterialApp.router setup
│ ├── app_router.dart # GoRouter configuration
│ ├── main_iran.dart # Entry point — Iran flavor
│ └── main_global.dart # Entry point — Global flavor
└── test/ # Mirrors lib/ structure

---

## 🚀 Setup & Run

### Prerequisites

- Flutter 3.44.x+ installed
- Android Studio / VS Code with Flutter plugin
- No API key needed (Open-Meteo is free & keyless)

### Run — Iran Flavor (default)

bash

# Run on connected device/emulator

flutter run -t lib/main_iran.dart --dart-define=FLAVOR=iran

# Run on specific device

flutter run -t lib/main_iran.dart --dart-define=FLAVOR=iran -d <device_id>

Run — Global Flavor
flutter run -t lib/main_global.dart --dart-define=FLAVOR=global

Build — Iran Flavor (APK for Cafe Bazaar / Myket)
flutter build apk --release -t lib/main_iran.dart --dart-define=FLAVOR=iran

Build — Global Flavor (AAB for Google Play)
flutter build appbundle --release -t lib/main_global.dart --dart-define=FLAVOR=global

Build — iOS (App Store)
flutter build ios --release -t lib/main_global.dart --dart-define=FLAVOR=global

## Code Generation

# Run after any changes to @riverpod annotated providers

dart run build_runner build --delete-conflicting-outputs

🧪 Testing

# Run all tests

flutter test

# Run with coverage

flutter test --coverage

# Run specific test file

flutter test test/features/weather/domain/usecases/get_weather_use_case_test.dart

🤝 Contributing
Fork the repository
Create a feature branch: git checkout -b feature/my-feature
Follow the existing code style (analysis_options.yaml is strict)
Write tests for new functionality
Ensure all tests pass: flutter test
Commit with conventional commits: feat:, fix:, docs:, refactor:, etc.
Push and open a Pull Request

📄 License
This project is licensed under the MIT License — see the LICENSE file for details.

🙏 Acknowledgments
Weather data by Open-Meteo (free, open-source)
Design inspiration: Apple Weather, AccuWeather, Xiaomi Weather
Visual identity: Lapis Lazuli — the deep blue gemstone
