# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter dating application with Firebase integration, featuring:
- Blog search functionality using Naver API
- Chat system with WebSocket/STOMP
- Firebase authentication, messaging, and storage
- Kakao Map integration
- Multi-language support (Korean/English)
- AppsFlyer analytics integration

## Architecture

### Core Structure
- `lib/core/`: Contains base classes, utilities, and shared services
  - `api/`: External API integrations (Naver, status checks)
  - `models/`: Data models with JSON serialization
  - `service/`: Core services (FCM, chat, crawling, performance monitoring)
  - `navigation/`: GoRouter-based navigation management
  - `utils/`: Utility classes for dialogs, permissions, notifications
- `lib/presentation/`: UI layer following MVVM pattern
  - `views/`: Screen implementations organized by feature
  - `viewmodel/`: Business logic with Riverpod state management
  - `widgets/`: Reusable UI components
- `lib/config/`: Environment-specific configurations for debug/release

### Key Dependencies
- State Management: Riverpod
- Navigation: GoRouter
- HTTP Client: Dio with Retrofit
- Firebase: Full suite (Auth, Firestore, Storage, Messaging, Analytics)
- UI: Flutter ScreenUtil for responsive design
- Internationalization: EasyLocalization

## Development Commands

### Flutter Commands
- `flutter run`: Start the app in debug mode
- `flutter analyze`: Run static analysis
- `flutter test`: Run unit tests
- `flutter build apk`: Build Android APK
- `flutter build ios`: Build iOS app
- `dart run build_runner build`: Generate code (JSON serialization, Retrofit)
- `dart run build_runner watch`: Watch for changes and regenerate code

### Firebase Functions (in functions/ directory)
- `npm run build`: Compile TypeScript functions
- `npm run lint`: Run ESLint
- `npm run serve`: Start local Firebase emulator
- `npm run deploy`: Deploy functions to Firebase

## Code Generation

This project uses code generation for:
- JSON serialization (`*.g.dart` files)
- Freezed data classes (`*.freezed.dart` files)
- Retrofit API clients

Run `dart run build_runner build --delete-conflicting-outputs` when model classes change.

## Environment Configuration

The app uses environment-specific configurations:
- Debug: `lib/config/debug/`
- Release: `lib/config/release/`
- Environment variables loaded from `assets/.env`

## Firebase Integration

Full Firebase setup including:
- Authentication with social logins
- Firestore for data persistence
- Cloud Functions for backend logic
- FCM for push notifications
- Remote Config for feature flags
- Analytics and Crashlytics

## Testing

- Unit tests in `test/` directory
- Widget tests using Flutter test framework
- Run tests with `flutter test`

## Internationalization

Uses EasyLocalization with translations in `assets/translations/`:
- `en-US.json` for English
- `ko-KR.json` for Korean