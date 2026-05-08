# Library Management System

A full-featured Flutter application for managing a library's books and authors inventory, built with Clean Architecture, Supabase backend, JWT authentication, and multilingual support.

---

## Features

### Authentication
- **Login Screen** — Email/password login via [dummyjson.com](https://dummyjson.com) REST API
- **Signup Screen** — Registration form with password confirmation and privacy policy checkbox
- **Auto-login** — Persisted JWT token; app opens directly to the main screen if session is valid
- **Token Refresh** — Automatic access token renewal on expiry
- **Form Validation** — Inline field errors + floating snackbar summary
- **Social Buttons** — Facebook and Google sign-in buttons (UI only)
- **Language Switcher** — Globe button on both auth screens (AR / EN / MS)

### Library Management
- **Books Module** — Add, edit, soft-delete and restore books with cover images
- **Authors Module** — Add, edit, soft-delete and restore authors with profile images
- **Trash** — 30-day soft-delete with permanent delete option
- **Search** — Live search across books and authors
- **Home Dashboard** — Live stats showing total books and authors count
- **Image Support** — URL-based cover/avatar images with colored-initial fallback

### App-wide
- **Multilingual** — Arabic / English / Malay with one-tap language switch
- **RTL Support** — Full right-to-left layout for Arabic
- **Persistent Language** — Remembers selected language across sessions
- **Real-time Backend** — Supabase PostgreSQL database

---

## Architecture

This project follows **Clean Architecture** with feature-based folder organisation:

```
lib/
├── core/                     # Shared utilities (no feature logic)
│   ├── constants/            # Colors, sizes, text styles, images, theme
│   ├── di/                   # Dependency injection (get_it + injectable)
│   ├── localization/         # AppLocalizations + easy_localization
│   ├── navigation/           # AppRouter (centralised navigation)
│   └── theme/                # App theme (Light + Arabic)
│
└── features/
    ├── auth/                 # Authentication feature
    │   ├── data/             # Models, remote datasource, repository impl
    │   ├── domain/           # Entities, repository interface, use cases
    │   └── presentation/     # AuthCubit, LoginScreen, SignupScreen, widgets
    │
    ├── books/                # Books feature
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    └── authors/              # Authors feature
        ├── data/
        ├── domain/
        └── presentation/
```

---

## Tech Stack

| Category | Package | Version |
|---|---|---|
| State Management | flutter_bloc | ^9.1.1 |
| Backend (Library) | supabase_flutter | ^2.8.4 |
| Auth API | http | ^1.2.2 |
| Dependency Injection | get_it + injectable | ^8.0.3 / ^2.5.0 |
| Localization | easy_localization | ^3.0.7 |
| SVG Icons | flutter_svg | ^2.0.14 |
| Token Storage | shared_preferences | ^2.5.3 |
| Grid Layout | flutter_staggered_grid_view | ^0.7.0 |
| Device Testing | device_preview | ^1.2.0 |

---

## Authentication Flow

```
App start
  └─ LoginScreen.initState → AuthCubit.checkAuth()
        ├─ No stored token  → stay on LoginScreen
        └─ Token found      → GET /auth/me
              ├─ Success    → navigate to MainScreen (silent)
              └─ Fail       → POST /auth/refresh
                    ├─ Success → navigate to MainScreen (silent)
                    └─ Fail    → clear tokens → stay on LoginScreen

User submits login form
  └─ AuthCubit.login(username, password)
        ├─ POST /auth/login → save tokens → navigate to MainScreen
        └─ Error            → show error snackbar
```

The API used is [dummyjson.com](https://dummyjson.com). Test credentials:
- **Username:** `emilys` &nbsp;|&nbsp; **Password:** `emilyspass`

Tokens are stored via `SharedPreferences` under the keys `auth_access_token` and `auth_refresh_token`.

---

## Supabase Schema

```sql
-- Authors table
create table authors (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  image_url text,
  created_at timestamptz default now()
);

-- Books table
create table books (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  published_year integer not null,
  author_id uuid references authors(id) on delete cascade,
  image_url text,
  created_at timestamptz default now()
);

-- Allow public access (adjust for production)
create policy "Allow all" on authors for all using (true);
create policy "Allow all" on books for all using (true);
```

---

## Localization

Translations are stored as JSON files in `assets/translations/`:

| File | Language | Direction |
|---|---|---|
| `ar.json` | Arabic | RTL |
| `en.json` | English | LTR |
| `ms.json` | Malay | LTR |

The app uses **easy_localization** with a custom `AppLocalizations` wrapper.
Language switch is available via a globe button in the auth screens and in the main AppBar.

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.11.1`
- A Supabase project

### Setup

**1. Clone the repository**
```bash
git clone https://github.com/YOUR_USERNAME/library_management_system.git
cd library_management_system
```

**2. Install dependencies**
```bash
flutter pub get
```

**3. Configure Supabase**

Open [lib/core/constants/app_string.dart](lib/core/constants/app_string.dart) and replace:
```dart
static const String supabaseUrl     = 'YOUR_SUPABASE_URL';
static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
```

**4. Run the SQL schema** in your Supabase dashboard → SQL Editor.

**5. Run the app**
```bash
flutter run -d chrome   # Web
flutter run             # Mobile
```

---

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart        # Color palette (primary: #7C3AED)
│   │   ├── app_images.dart        # SVG asset path constants
│   │   ├── app_size.dart          # Spacing, radius & button height constants
│   │   ├── app_string.dart        # Supabase config, font names
│   │   └── app_text_style.dart    # Typography (Inter EN/MS + Rakkas AR)
│   ├── di/
│   │   ├── injection.dart         # get_it configurator entry point
│   │   └── injection.config.dart  # Auto-generated registrations
│   ├── localization/
│   │   ├── app_localizations.dart # Typed getters for every translation key
│   │   └── locale_keys.g.dart     # Generated key constants
│   ├── navigation/
│   │   └── app_router.dart        # toMain / toLogin / toSignup / pop
│   └── theme/
│       └── app_theme.dart         # Light theme + Arabic overrides
│
└── features/
    ├── auth/
    │   ├── data/
    │   │   ├── datasources/
    │   │   │   └── auth_remote_datasource.dart   # POST /auth/login, GET /auth/me, POST /auth/refresh
    │   │   ├── models/
    │   │   │   └── auth_user_model.dart           # fromJson
    │   │   └── repositories/
    │   │       └── auth_repository_impl.dart      # token persistence via SharedPreferences
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   └── auth_user.dart
    │   │   ├── repositories/
    │   │   │   └── i_auth_repository.dart
    │   │   └── usecases/
    │   │       ├── login_usecase.dart
    │   │       ├── get_current_user_usecase.dart
    │   │       └── refresh_token_usecase.dart
    │   └── presentation/
    │       ├── cubits/
    │       │   ├── auth_cubit.dart   # login / checkAuth / logout
    │       │   └── auth_state.dart   # enum AuthStatus { initial, loading, authenticated, unauthenticated, error }
    │       ├── screens/
    │       │   ├── login_screen.dart
    │       │   └── signup_screen.dart
    │       └── widgets/
    │           ├── auth_language_button.dart  # Globe popup (AR / EN / MS)
    │           ├── auth_logo.dart             # Gradient icon + app name
    │           ├── auth_or_divider.dart       # "OR" divider line
    │           ├── auth_submit_button.dart    # Gradient button with loading spinner
    │           ├── auth_text_field.dart       # Input with inline error + password toggle
    │           └── social_auth_button.dart    # Facebook / Google buttons
    │
    ├── books/
    │   ├── data/ ...
    │   ├── domain/ ...
    │   └── presentation/
    │       ├── cubits/              # BooksCubit + BooksState
    │       ├── screens/             # BooksScreen
    │       └── widgets/             # BookListItem, AddBookForm
    │
    └── authors/
        ├── data/ ...
        ├── domain/ ...
        └── presentation/
            ├── cubits/              # AuthorsCubit + AuthorsState
            ├── screens/             # AuthorsScreen
            └── widgets/             # AuthorListItem, AddAuthorForm
```

---

## Design

- **Primary color:** `#7C3AED` (Purple)
- **AppBar:** Purple gradient (`#7C3AED` → `#5B21B6`)
- **Fonts:** Inter (EN/MS) + Rakkas (AR)
- **Author avatars:** Colored initials fallback or network image
- **Book covers:** Colored block fallback or network image
- **Auth screens:** White card layout with social login buttons, inline field validation, floating snackbars

---

## State Management Pattern

All cubits use an **enum-based status** pattern:

```dart
// Auth example
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthUser? user;
  final String? errorMessage;
}

// Books example
enum BooksStatus { initial, loading, adding, success, error }

class BooksState extends Equatable {
  final List<Book> books;
  final BooksStatus status;
  final String? errorMessage;

  bool get isLoading => status == BooksStatus.loading;
  bool get isAdding  => status == BooksStatus.adding;
}
```

---

## License

MIT License
