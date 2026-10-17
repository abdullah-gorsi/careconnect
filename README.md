# CareConnect

CareConnect is a Flutter-based healthcare companion application that brings everyday care information and tasks into one focused experience. Users can create an account, manage their profile, track health information, organize appointments, review care reminders, and communicate through messages.

The project is designed as a cross-platform application for Android, iOS, web, desktop, and other Flutter-supported platforms. Firebase provides authentication and cloud data services, while GetX provides routing and dependency management.

## Features

### Authentication and account access

- Splash screen and guided onboarding flow.
- Account registration with display name, email, and password.
- Email and password sign-in.
- Email verification flow.
- OTP verification flow.
- Password reset by email.
- Change password with re-authentication.
- Sign out from the home and settings experiences.

### Healthcare dashboard

- Personalized home dashboard.
- Health index summary.
- Sleep and activity overview cards.
- Care reminders for medication and other tasks.
- Quick access to appointments, messages, profile, and settings.

### Appointments

- Create appointments.
- View appointments in real time.
- Update appointment details.
- Mark appointments as complete or incomplete.
- Delete appointments.
- Store appointment data per authenticated user in Cloud Firestore.

### Health and care experience

- Health tracking screen for viewing health metrics.
- Profile screen for user information and account actions.
- Messages screen for care-related communication UI.
- Settings screen for notifications, weekly summaries, accessibility options, and support links.
- Light and dark themes with a persisted dark-mode preference.

## Technology Stack

- **Flutter**: Cross-platform UI and application framework.
- **Dart**: Programming language.
- **Firebase Authentication**: Email/password account authentication, verification, password reset, and account security.
- **Cloud Firestore**: User-specific appointment and care data with real-time updates.
- **GetX**: Named routes, bindings, dependency injection, and reactive state updates.
- **Shared Preferences**: Local persistence for display preferences such as dark mode.
- **Google Fonts**: Manrope typography used by the application theme.
- **Image Picker**: Profile image selection support.
- **Permission Handler**: Platform permission handling support.

## Project Structure

```text
lib/
├── binding/                 Global dependency bindings
├── core/
│   ├── routes/              GetX route definitions
│   ├── services/            Firebase and application services
│   └── theme/               Colors, themes, and theme controller
├── data/
│   └── repositories/        Data access repositories
├── features/
│   ├── appointments/        Appointment screens, models, bindings, and viewmodels
│   ├── auth/                Authentication screens, bindings, and viewmodels
│   ├── health_tracking/     Health metric models and screens
│   ├── home/                Dashboard and home bindings
│   ├── messages/            Messaging screens and models
│   ├── onboarding/          First-run onboarding screens
│   ├── profile/             Profile screens, services, and repositories
│   ├── settings/            User settings screen
│   └── splash/              Startup screen
├── shared/                  Reusable widgets used across features
└── main.dart                Application entry point
```

## Requirements

Before running the project, install:

- Flutter SDK with Dart support.
- Android Studio and an Android SDK for Android builds, or Xcode for iOS builds on macOS.
- A Firebase project with Authentication and Cloud Firestore enabled.
- A supported device, emulator, or browser.

Check the local Flutter installation with:

```bash
flutter doctor
```

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/abdullah-gorsi/careconnect.git
cd careconnect
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure Firebase

Create or select a Firebase project and register the platforms you intend to use. Configure the native Firebase files for your target platforms:

- Android: `android/app/google-services.json`
- iOS: `ios/Runner/GoogleService-Info.plist`
- Web: Firebase initialization options in the application entry point

Enable the following Firebase services:

1. Authentication with the Email/Password provider.
2. Cloud Firestore.
3. Any additional storage or messaging services required by your deployment.

Review the Firestore rules before deploying the application. Do not commit private credentials, service-account keys, or production secrets to the repository.

### 4. Run the application

List available devices:

```bash
flutter devices
```

Run on the selected device:

```bash
flutter run
```

Run in a browser:

```bash
flutter run -d chrome
```

## Common Development Commands

```bash
# Format Dart files
dart format .

# Analyze the project
flutter analyze

# Run tests
flutter test

# Build an Android APK
flutter build apk --release

# Build an Android App Bundle
flutter build appbundle --release

# Build for the web
flutter build web --release
```

## Data Model Overview

Appointment records are stored under the authenticated user document:

```text
users/{userId}/appointments/{appointmentId}
```

Appointment operations are implemented through the appointments service and include create, read, update, delete, and completion status updates. Appointment lists use Firestore snapshots to provide real-time changes in the app.

## Theme and Preferences

CareConnect uses a centralized light and dark `ThemeData` configuration. The theme controller is initialized before the application starts, reads the saved preference from Shared Preferences, and exposes the active `ThemeMode` reactively through GetX.

Users can change the preference from:

```text
Settings -> Display & accessibility -> Dark mode
```

The selected mode remains active after the application is restarted on the same device or browser profile.

## Security Notes

- Firebase Authentication controls access to user accounts.
- User-specific Firestore data should be protected with production Firestore security rules.
- Never rely only on client-side checks for authorization.
- Do not commit Firebase service-account credentials or other private secrets.
- Review platform permissions before publishing a production build.

## Current Scope

CareConnect is an actively developed application foundation and prototype for a connected healthcare experience. Some screens, notifications, messaging workflows, and support actions may require additional backend integration before production release.

Before shipping to users, validate authentication flows, Firestore rules, error handling, accessibility, privacy requirements, platform permissions, and production monitoring.

## License

This project is currently private and does not declare an open-source license.
