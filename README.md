# Order Now (order_now)

Order Now is a Flutter mobile application that provides a minimal food-ordering client experience: sign in, browse products, add items to cart, place orders and view order history. This repository contains the Flutter front-end for the app.

## Features
- Login / Authentication screens
- Home / Product listing
- Product detail and add-to-cart
- Cart management
- Order history
- Profile screen and basic settings
- Portrait-only UI (app locked to portrait)

## Stack
- Language: Dart (Flutter)
- Flutter SDK: compatible with Dart SDK ^3.11.5 (see pubspec.yaml)
- Key dependencies:
  - dio — HTTP client and networking
  - shared_preferences — local key/value persistence
  - flutter_svg — SVG image rendering
  - gap — spacing helpers
  - cupertino_icons — platform icons

## Repository layout
lib/
  main.dart            — application entrypoint (initialization + orientation)
  root.dart            — main app shell (bottom navigation + PageView)
  splash_page.dart     — splash screen
  core/                — constants, networking and utilities
    constants/         — app-wide consts (colors, strings)
    network/           — network helpers
    utils/             — helper utilities
  features/
    auth/              — authentication UI and logic
    home/              — home screen & product listings
    product/           — product details
    cart/              — cart UI and logic
    order/             — order history screens
    payment/           — payment screens (if used)
  shared/
    widgets/           — shared UI components
android/               — Android platform project
ios/                   — iOS platform project
web/, macos/, windows/ — Flutter platform folders (if present)
test/                  — unit/widget tests (if present)

## How to run locally
1. Ensure Flutter is installed and configured:
   https://flutter.dev/docs/get-started/install

2. From the project root, get dependencies:
   flutter pub get

3. Run on an emulator or connected device:
   flutter run

4. Static analysis / lints:
   flutter analyze

5. Build artifacts:
   - Android APK: flutter build apk --release
   - iOS (macOS, with signing): flutter build ios --release

## Configuration and environment
- The repository does not include a .env or secrets file. If the app requires backend endpoints or API tokens, set them in the networking layer (check files under lib/core/network and lib/features/* for where endpoints or tokens are referenced).
- Orientation is forced to portrait in lib/main.dart.

## Contributing
- This repo uses flutter_lints. Please run `flutter analyze` and `flutter test` before opening a PR.
- Follow existing code patterns: each feature is organized under lib/features/<feature> and UI widgets are in lib/shared/widgets.

## Notes and TODOs (found while reading the code)
- Verify where the API base URL is set and add docs on required backend endpoints and sample request/response shapes.
- Add screenshots or a demo GIF to the README to improve onboarding.
- If the app needs CI/CD or automated tests, consider adding GitHub Actions workflows to run `flutter analyze` and `flutter test`.
