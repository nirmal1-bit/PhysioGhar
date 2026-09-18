# PhysioGhar Flutter App

PhysioGhar is a Flutter application for managing physiotherapy sessions. The
primary workflow is the therapist application described in the Flutter
Developer Technical Assignment, with patient booking support included for an
end-to-end experience.

## Requirements

- Flutter 3.41.9
- Dart 3.11.5
- Android SDK and an Android device/emulator
- The PhysioGhar FastAPI backend for API-backed flows

The app can also be opened as a regular Flutter project for UI development,
but login, profiles, schedules, bookings, notes, and complaints require a
running backend which for now it has as it uses https://prod.creativeinkflow.tech/api/v1 which is hosted backend url.

## Build apk file
The build apk file is in google drive you can access it through this link

Google drive: https://drive.google.com/drive/folders/134KksElsrOFAJw0x0XIpbAtBZQLHX3Vf?usp=drive_linkk

## Run locally

Install Flutter dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

The API base URL is configured in
`lib/core/providers/core_providers.dart`. It currently points to the deployed
API:

```text
https://prod.creativeinkflow.tech/api/v1
```

For local development, replace it with the host address reachable by the
device, for example:

```text
http://localhost:8000/api/v1
```

## Code generation

Freezed and JSON serialization models are generated with build_runner:

```bash
dart run build_runner build
```

For a clean regeneration when generated files conflict:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Quality checks

```bash
flutter analyze
dart format lib
```

## Build an APK

Debug APK:

```bash
flutter build apk --debug
```

Release APK:

```bash
flutter build apk --release
```

The generated APK is written under `build/app/outputs/flutter-apk/`.

## Packages and why they are used
The packages below are the project-specific packages added for PhysioGhar.

### runtime dependencies

- `flutter_riverpod` — centralized application state management.
- `go_router` — scalable application navigation.
- `dio` — backend network communication.
- `dartz` — consistent success and failure result handling.
- `shared_preferences` — lightweight local session persistence.
- `internet_connection_checker` — network connectivity detection.
- `image_picker` — device image selection.
- `google_fonts` — assignment typography and font styling.
- `flutter_screenutil` — responsive mobile sizing.
- `google_nav_bar` — application bottom navigation.
- `loading_animation_widget` — loading-state animations.
- `top_snackbar_flutter` — success and error notifications.
- `pretty_dio_logger` — development API request logging.
- `flutter_localizations` — Flutter's localization delegates and locale-aware
  Material, Cupertino, and widget translations.
- `intl` — locale-aware formatting support used by the localization system.
- `freezed_annotation` — immutable model annotations.
- `json_annotation` — JSON model annotations.

### Development and build dependencies

These project-specific packages are used while generating files, preparing
platform assets, or building the application. They are not application
features used directly at runtime.

- `build_runner` — source-code generation orchestration.
- `freezed` — immutable model generation.
- `json_serializable` — JSON serialization-code generation.
- `flutter_launcher_icons` — platform launcher-icon generation.
- `flutter_native_splash` — native splash-screen generation.
- `rename` — application identity and display-name management.

## Project structure

```text
lib/
├── core/
│   ├── api/              # Remote-source and API error handling
│   ├── common/widgets/   # Reusable buttons, fields, empty states, avatars
│   ├── constants/        # API endpoints and storage keys
│   ├── network/          # Connectivity and auth interceptor
│   ├── providers/        # Shared Dio/session providers
│   ├── router/           # GoRouter routes
│   ├── session/          # Persisted session service
│   └── theme/            # Colors, dimensions, typography, app theme
├── features/
│   ├── auth/             # Login, registration, token session
│   ├── dashboard/        # Therapist home dashboard
│   ├── schedule/         # Weekly availability and slot management
│   ├── booking/          # Therapist booking/session management
│   ├── patient_notes/    # Therapist patient records and session notes
│   ├── patient/          # Patient therapist discovery and booking
│   ├── profile/          # Profile, settings, complaints, policy screens
│   ├── home/             # Therapist navigation shell
│   └── splash/           # Startup session routing
└── utils/                # Shared UI, date, image, and keyboard utilities
```

Feature folders use a lightweight clean-architecture structure:

```text
feature/
├── data/          # Freezed models and remote repository implementations
├── domain/        # Repository contracts
└── presentation/  # Riverpod providers, screens, and widgets
```

### Core layer

The `core/` directory contains application-wide building blocks that are not
owned by one feature:

- `core/api/` — shared remote-request behavior, API exceptions, error parsing,
  and the `BaseRemoteSource` used by repositories.
- `core/common/widgets/` — reusable visual components such as buttons, text
  fields, avatars, app bars, loading indicators, settings tiles, and empty
  states.
- `core/constants/` — API endpoint paths and local-storage keys.
- `core/extensions/` — reusable Dart and Flutter extensions, such as responsive
  sizing and string validation helpers.
- `core/network/` — connectivity abstraction and the Dio authentication
  interceptor.
- `core/providers/` — shared Riverpod providers for Dio, connectivity,
  `SharedPreferences`, and `SessionService`.
- `core/router/` — centralized GoRouter configuration and route names.
- `core/session/` — persistence operations for token, account type, onboarding,
  theme, and session cleanup.
- `core/theme/` — app colors, dimensions, typography, and Material theme
  configuration.
- `core/typedef/` — shared type aliases, including repository response types.

### Feature layers

Each feature is isolated under `lib/features/<feature_name>/` and is divided
into three layers.

#### Data layer

The `data/` layer deals with external data sources and transport models:

- `data/models/` contains request and response models representing API JSON.
  Freezed and JSON-generated files belong beside their source model.
- `data/repositories/` contains concrete repository implementations. These
  classes call Dio through `BaseRemoteSource`, convert JSON into typed models,
  and return `Either<AppError, Result>` values.

The data layer knows about Dio and backend endpoints. Screens do not call Dio
directly.

#### Domain layer

The `domain/` layer contains feature contracts and business-facing types:

- `domain/repositories/` defines abstract repository interfaces.
- The interfaces describe what a feature can do without depending on Dio,
  HTTP response objects, or widget code.

This allows the presentation layer to depend on a stable contract and keeps
the concrete API implementation replaceable.

#### Presentation layer

The `presentation/` layer contains everything required to display and interact
with a feature:

- `presentation/providers/` contains Riverpod controllers and feature
  providers.
- `presentation/screens/` contains route-level pages and their form/list
  composition.
- `presentation/widgets/` contains feature-specific reusable widgets that are
  too specialized for `core/common/widgets/`.
- `presentation/models/` contains navigation arguments or other UI-only data
  structures that are not backend entities.

Screens render state and send user actions to controllers. They do not contain
raw HTTP requests or database-style logic.

### Shared utilities

The `utils/` directory contains cross-feature helpers that are not widgets or
feature business logic:

- `app_utils.dart` — image selection, keyboard dismissal, confirmation dialogs,
  and success/error notifications.
- `date_utils.dart` — shared API date formatting and display formatting.
- Other utility files — small reusable helpers that do not belong to a
  specific feature.

## State management and dependency injection

The app uses Riverpod instead of a service locator. A provider is the place
where an object is created, exposed, and connected to its dependencies.

### Dependency flow

```text
ProviderScope
    ↓
Core providers
    ├── Dio + auth interceptor
    ├── NetworkInfo
    ├── SharedPreferences
    └── SessionService
    ↓
Feature repository provider
    ↓
Feature controller/provider
    ↓
Screen and feature widgets
```

For example, `profileRepositoryProvider` reads `dioProvider` and
`networkInfoProvider`, constructs `ProfileRepositoryImpl`, and exposes it as
the `ProfileRepository` interface. `profileControllerProvider` then reads that
repository and exposes profile state to profile screens.

## Design approach

The UI follows the assignment's healthcare style:

- Cream background and rounded white cards
- Pine/green primary color with amber highlights
- Fraunces for headings
- Inter for body text and controls
- Reusable spacing, typography, buttons, fields, avatars, and empty states
- Loading, error, validation, and success feedback for API-backed actions

## Assumptions

- The assignment's main evaluation workflow is the therapist application.
- Backend integration was added even though the assignment permits mock/local
  data.
- Therapist and patient accounts share one backend users table and are routed
  by the backend-provided account type.
- Therapist professional profile fields are separate from shared account
  identity fields.
- The complaint feature submits reports for future admin handling; an admin
  dashboard and reply workflow are outside the assignment scope.
- Language selection stores the selected preference and demonstrates the
  English/Nepali option without translating every screen.

