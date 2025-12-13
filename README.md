# Referral App

A referral app that lets users easily invite friends, track referrals, and earn rewards for every successful signup.

---

## Table of Contents

- [Architectural Decisions](#architectural-decisions)
  - [State Management](#state-management)
  - [Layered Architecture](#layered-architecture)
- [Assumptions](#assumptions)
- [Setup Instructions](#setup-instructions)
- [Testing Instructions](#testing-instructions)
- [App Screenshots](#app-screenshots)
- [Working with Translations](#working-with-translations)

---

## Architectural Decisions

### State Management

**Approach: BLoC (Business Logic Component) Pattern**

This project uses the **BLoC/Cubit pattern** with the `flutter_bloc` package for state management.

#### Justification

1. **Separation of Concerns**: BLoC pattern cleanly separates business logic from UI, making the codebase more maintainable and testable.

2. **Predictable State Management**: The unidirectional data flow (Event → BLoC → State) makes it easier to reason about application state and debug issues.

3. **Testability**: BLoC/Cubit classes are pure Dart classes that can be easily unit tested without requiring widget tests.

4. **Reusability**: Business logic encapsulated in BLoCs can be shared across multiple widgets without tight coupling.

5. **Reactive Programming**: Built on streams, BLoC naturally handles asynchronous operations and state changes.

#### Implementation Details

- **BLoC** is used for complex state management scenarios (e.g., `DashboardBloc`, `TransactionBloc`)
- **Cubit** is used for simpler state management (e.g., `ThemeCubit`, `SplashCubit`)
- All BLoCs/Cubits are provided at the app level via `MultiBlocProvider` in `AppProviders`
- State changes are handled through `BlocBuilder` and `BlocListener` widgets

#### Example Structure

```
feature/
  └── dashboard/
      └── presentation/
          └── bloc/
              ├── dashboard_bloc.dart
              ├── dashboard_event.dart
              └── dashboard_state.dart
```

---

### Layered Architecture

**Approach: Clean Architecture with Feature-Based Organization**

This project follows **Clean Architecture** principles with a **feature-based** folder structure, organized into three main layers:

#### Architecture Layers

1. **Presentation Layer** (`presentation/`)
   - Contains UI components (widgets, screens)
   - BLoCs/Cubits for state management
   - View models and UI-specific logic

2. **Domain Layer** (`domain/`)
   - Business logic and use cases
   - Repository interfaces (abstractions)
   - Domain entities (business objects)

3. **Data Layer** (`data/`)
   - Repository implementations
   - Data models (with JSON serialization)
   - API clients and data sources
   - **Supabase integration** for data storage and session management

#### Project Structure

```
lib/
├── app/                    # App-level configuration
│   ├── cubit/             # App-wide state (Theme, etc.)
│   └── view/              # App widget and providers
├── core/                   # Shared utilities and infrastructure
│   ├── constants/         # App constants
│   ├── di/                # Dependency injection setup
│   ├── exceptions/        # Custom exceptions
│   ├── network/           # Network layer (API client)
│   ├── route/             # Navigation/routing
│   └── services/          # Core services (Storage, Supabase)
├── feature/               # Feature modules
│   ├── auth/
│   │   ├── signIn/
│   │   │   ├── data/      # Data layer
│   │   │   ├── domain/    # Domain layer
│   │   │   └── presentation/ # Presentation layer
│   │   └── signup/
│   ├── dashboard/
│   ├── profile/
│   ├── splash/
│   └── transaction/
├── shared/                 # Shared across features
│   ├── data/             # Shared data models and repositories
│   └── domain/           # Shared domain interfaces
└── widgets/              # Reusable UI components
```

#### Justification

1. **Separation of Concerns**: Each layer has a clear responsibility:
   - **Presentation**: UI and user interactions
   - **Domain**: Business rules and logic (framework-independent)
   - **Data**: Data fetching and persistence

2. **Testability**: Domain layer can be tested independently of UI and data sources.

3. **Maintainability**: Feature-based organization makes it easy to locate and modify code related to specific features.

4. **Scalability**: New features can be added without affecting existing code, following the same structure.

5. **Dependency Rule**: Dependencies flow inward (Presentation → Domain ← Data), ensuring business logic remains independent.

#### Dependency Injection

- **GetIt** is used for dependency injection
- All dependencies are registered in `lib/core/di/di.dart`
- Repositories, use cases, and services are injected into BLoCs/Cubits
- Enables easy mocking for testing and swapping implementations

#### Backend & Data Storage

**Supabase** is used as the backend service for:

1. **Data Storage**: 
   - All application data (users, wallets, transactions, referrals) is stored in Supabase PostgreSQL database
   - Real-time database subscriptions for live updates
   - Row Level Security (RLS) policies for data access control

2. **Session Management**:
   - User authentication and session handling via Supabase Auth
   - Secure token storage using `flutter_secure_storage`
   - Automatic session refresh and token management
   - Session persistence across app restarts

3. **Authentication**:
   - Email/password authentication
   - User registration and login flows
   - Secure password hashing and validation

4. **Database Operations**:
   - CRUD operations for all entities (wallets, transactions, referrals)
   - Complex queries for dashboard data aggregation
   - Transaction history retrieval with pagination
   - Referral tracking and reward calculations

The Supabase service is abstracted through repository interfaces in the domain layer, allowing for easy testing and potential backend migration if needed.

#### REST API Integration (Sample Code)

**Note**: While the app currently uses Supabase for backend services, sample code for REST API integration has been included in the project for reference and future use.

**Location**: 
- Network client: `lib/core/network/client/`
- Sample implementation: `lib/feature/auth/signIn/data/repository_impl/signin_repository_impl.dart`

**Components**:

1. **BaseClient** (`lib/core/network/client/base_client.dart`):
   - Abstract interface defining HTTP methods (GET, POST, PUT, PATCH, DELETE)
   - Image upload support
   - Standardized request/response handling

2. **BaseClientImpl** (`lib/core/network/client/base_client_impl.dart`):
   - Complete implementation using **Dio** HTTP client
   - Features include:
     - Automatic token refresh on 401 errors
     - Request caching with SharedPreferences
     - Loading dialog management
     - Multipart form data support
     - Custom headers and authentication
     - Request/response logging (PrettyDioLogger)
     - Internet connectivity checking
     - Error handling and retry logic

3. **Helper Functions** (`lib/core/network/functions/`):
   - `get_header.dart`: Generates request headers with authentication tokens
   - `get_parsed_data.dart`: Parses API responses and converts to domain models

4. **Sample Usage** (`lib/feature/auth/signIn/data/repository_impl/signin_repository_impl.dart`):
   - Commented-out example code showing how to use the REST API client
   - Demonstrates:
     - Making GET requests with query parameters
     - Parsing responses using `getParsedData` helper
     - Error handling with Either pattern

**Example Usage** (from signin_repository_impl.dart):

```dart
// Sample REST API implementation (commented out)
// @override
// Future<Either<UserModel, Failure>> login({
//   String? limit,
//   String? page,
// }) async {
//   final response = await _client.getRequest(
//     baseUrl: EnvironmentConstants.baseUrl,
//     path: ApiConstants.kSignUp,
//     queryParameters: {'limit': limit, 'page': page},
//   );
//   return getParsedData(response, UserModel.fromJson);
// }
```

**To Use REST API Instead of Supabase**:

1. Uncomment the REST API code in repository implementations
2. Register `BaseClient` in dependency injection (`lib/core/di/di.dart`)
3. Update repository implementations to use `BaseClient` instead of Supabase
4. Configure API endpoints in `lib/core/constants/api_constants.dart`
5. Set base URL in `lib/core/constants/environment_constants.dart`

This architecture allows for easy switching between Supabase and REST API backends without changing the domain layer or presentation logic.

#### Data Flow

```
UI (Widget) 
  → BLoC/Cubit (Presentation)
    → UseCase (Domain)
      → Repository Interface (Domain)
        → Repository Implementation (Data)
          → Supabase (Data Storage & Session Management)
```

---

## Assumptions

### Technical Assumptions

1. **Backend Service - Supabase**: 
   - The app uses **Supabase** for data storage (PostgreSQL database) and session management
   - Supabase project is configured with proper credentials (API URL and anon key)
   - Database schema is set up with required tables (users, wallets, transactions, referrals)
   - Row Level Security (RLS) policies are configured for data access control
   - Supabase Auth is enabled and configured for user authentication
   - Session tokens are managed by Supabase Auth and stored securely using `flutter_secure_storage`

2. **Network Connectivity**: The app includes connectivity checking, but assumes users have internet access for core features to function properly.

3. **Platform Support**: The app is designed to work on iOS, Android, Web, and Windows, but platform-specific configurations may be required.

4. **Secure Storage**: Sensitive data (tokens, credentials) are stored using `flutter_secure_storage`, which requires platform-specific setup.

5. **Code Generation**: The project uses code generation (`freezed`, `json_serializable`). Assumes `build_runner` is run after model changes.

### Business Logic Assumptions

1. **Referral System**: 
   - Users can refer others using a unique referral code
   - Rewards are triggered when a referred user completes their first transaction
   - Referral tracking is managed server-side

2. **Wallet System**:
   - Each user has a wallet associated with their account (Opening balance is 100)
   - Wallet balance is maintained and updated through transactions
   - Transaction history is maintained per user

3. **Transaction Flow**:
   - Users can send transactions to other users by email
   - First transaction triggers a reward for the referrer
   - Transaction validation and processing occur server-side

4. **Authentication & Session Management**:
   - User sessions are managed through **Supabase Auth**
   - Authentication tokens are stored securely using `flutter_secure_storage`
   - Session persistence across app restarts is handled by Supabase
  
   - Logout clears all stored session data and invalidates tokens

---

## Setup Instructions

### Prerequisites

- **Flutter SDK**: Version 3.38.0 or higher
- **Dart SDK**: Version 3.10.0 or higher
- **IDE**: VS Code or Android Studio with Flutter extensions
- **Platform-specific tools**:
  - For Android: Android Studio with Android SDK
  - For iOS: Xcode (macOS only)
  - For Web: Chrome (for testing)

### Installation Steps

1. **Clone the repository** (if applicable):
   ```sh
   git clone <repository-url>
   cd referral_app
   ```

2. **Install Flutter dependencies**:
   ```sh
   flutter pub get
   ```

3. **Run code generation** (if models have been modified):
   ```sh
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Configure Supabase** (if not already configured):
   - Create a Supabase project at [supabase.com](https://supabase.com)
   - Get your project's API URL and anon key from the Supabase dashboard
   - Configure Supabase credentials in your environment-specific configuration files
   - Set up the database schema with required tables:
     - `users` (extended user profiles)
     - `wallets` (user wallet balances)
     - `transactions` (transaction history)
     - `referrals` (referral relationships)
   - Configure Row Level Security (RLS) policies for data access
   - Enable Supabase Auth for authentication
   - The app uses Supabase for:
     - **Data Storage**: All application data is stored in Supabase PostgreSQL database
     - **Session Management**: User sessions are managed through Supabase Auth with secure token storage

5. **Generate localizations** (optional):
   ```sh
   flutter gen-l10n --arb-dir="lib/l10n/arb"
   ```

### Running the App

This project contains 3 flavors:

- **development**
- **staging**
- **production**

#### Using Command Line

```sh
# Development
flutter run --flavor development --target lib/main_development.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor production --target lib/main_production.dart
```

---

## Testing Instructions

### Test Accounts

The following test accounts are available for testing the referral system:

#### Account created Without Referral Code

- **Email**: `xuna@test.com`
- **Password**: `123456@aA`

This account can be used to test:
- User registration and login
- Dashboard functionality
- Transaction sending
- Referral code generation and sharing

#### Referred Account (This account is created with a referral code from the first account)

- **Email**: `xuno@referred.com`
- **Password**: `123456@aA`


### Testing Scenarios

#### 1. User Registration and Login

1. Launch the app
2. Navigate to the Sign Up screen (You can use the test account credentials to sign up)
3. Register a new account or use the test account credentials
4. Verify successful login and navigation to dashboard

#### 2. Referral Flow

1. Log in with `xuna@test.com`
2. Navigate to the dashboard
3. Copy your referral code
4. Share the referral code with another user
5. Log out and register a new account using the referral code
6. Complete the first transaction with the new account
7. Verify that the referrer (`xuna@test.com`) receives a reward

#### 3. Transaction Flow

1. Log in with either test account
2. Navigate to the transaction screen
3. Enter recipient email address
4. Enter transaction amount
5. Send the transaction
6. Verify transaction appears in history
7. Verify wallet balance updates

#### 4. Dashboard Features

1. Log in and view dashboard
2. Verify wallet balance display
3. Check referral count
4. View recent transactions
5. Test theme toggle (light/dark mode)

#### 5. Profile Management

1. Navigate to profile screen
2. View user information
3. Test logout functionality
4. Verify session is cleared after logout

---

## App Screenshots

### Authentication Screens

#### Light Theme - Login
![Light Login](app_screenshots/light_login.jpg)

#### Dark Theme - Login
![Dark Login](app_screenshots/dark_login.jpg)

#### Dark Theme - Register
![Dark Register](app_screenshots/dark_register.jpg)

### Dashboard Screens

#### Light Theme - Dashboard
![Light Dashboard](app_screenshots/light_dashboard.jpg)

#### Dark Theme - Dashboard
![Dark Dashboard](app_screenshots/dark_dashboard.jpg)

### Transaction Screens

#### Send Transaction - Active
![Send Transaction Active](app_screenshots/send_transaction_active.jpg)

#### Send Transaction - Disabled
![Send Transaction Disabled](app_screenshots/send_transaction_disable.jpg)

### Profile Screen

#### Profile
![Profile](app_screenshots/profile.jpg)

#### Logout
![Logout](app_screenshots/logout.jpg)

---

## Working with Translations

This project relies on `flutter_localizations` and follows the official internationalization guide for Flutter.

**Note**: This project is not using translations yet. It is just a sample and shows how to add translations to a project.

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:referral_app/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

Alternatively, run `flutter run` and code generation will take place automatically.

---

## Additional Information

### Key Technologies

- **Flutter**: 3.38.0
- **Dart**: 3.10.0
- **State Management**: BLoC/Cubit (flutter_bloc)
- **Dependency Injection**: GetIt
- **Routing**: GoRouter
- **Backend & Database**: **Supabase**
  - PostgreSQL database for data storage
  - Supabase Auth for authentication and session management
  - Real-time database subscriptions
  - Row Level Security (RLS) for data access control
- **REST API Integration**: Sample code included in `lib/core/network/` for future REST API integration
  - BaseClient implementation using Dio
  - Complete HTTP methods (GET, POST, PUT, PATCH, DELETE)
  - Token refresh, caching, and error handling
  - Sample usage in signin repository
- **Code Generation**: Freezed, json_serializable
- **Form Validation**: Formz
- **Secure Storage**: flutter_secure_storage (for session tokens)

### Code Quality

- The codebase follows Flutter and Dart best practices
- Clean Architecture principles are applied throughout
- SOLID principles are followed
- Code is documented where necessary
- Error handling is implemented using Either pattern (dartz)
- Custom exceptions are used for better error management
