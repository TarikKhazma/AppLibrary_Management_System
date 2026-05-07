# Library Management System

A full-featured Flutter application for managing a library's books and authors inventory, built with Clean Architecture, Supabase backend, and multilingual support.

---

## Features

- **Books Module** — Add, view, and delete books with cover images
- **Authors Module** — Add, view, and delete authors with profile images
- **Home Dashboard** — Live stats showing total books and authors count
- **Image Support** — URL-based images for both books and authors
- **Multilingual** — Arabic / English / Malaysian with one-tap language switch
- **RTL Support** — Full right-to-left layout for Arabic
- **Persistent Language** — Remembers selected language across sessions
- **Real-time Backend** — Supabase PostgreSQL database
- **Device Preview** — Built-in device preview for testing across screen sizes

---

## Architecture

This project follows **Clean Architecture** with three distinct layers:

```
lib/
├── core/                          # Shared utilities
│   ├── constants/                 # Colors, sizes, strings, text styles, theme
│   ├── di/                        # Dependency injection (get_it)
│   ├── localization/              # AppLocalizations + easy_localization
│   └── theme/                     # App theme (Light + Arabic)
│
├── domain/                        # Business logic (no Flutter dependencies)
│   ├── entities/                  # Author, Book
│   ├── repositories/              # Abstract interfaces
│   └── usecases/                  # GetAuthors, GetBooks, AddAuthor, AddBook
│
├── data/                          # Data layer
│   ├── datasources/               # Supabase remote data sources
│   ├── models/                    # AuthorModel, BookModel (JSON serialization)
│   └── repositories/              # Repository implementations
│
└── presentation/                  # UI layer
    ├── cubits/                    # State management (Authors, Books, Locale)
    ├── screens/                   # Home, Authors, Books, Main
    └── widgets/                   # Reusable UI components
```

---

## Tech Stack

| Category | Package | Version |
|---|---|---|
| State Management | flutter_bloc | ^9.1.1 |
| Backend | supabase_flutter | ^2.8.4 |
| Dependency Injection | get_it + injectable | ^8.0.3 / ^2.5.0 |
| Localization | easy_localization | ^3.0.7 |
| SVG Icons | flutter_svg | ^2.0.14 |
| Device Testing | device_preview | ^1.2.0 |
| Grid Layout | flutter_staggered_grid_view | ^0.7.0 |
| Persistence | shared_preferences | ^2.5.3 |

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
| `ms.json` | Malaysian | LTR |

The app uses **easy_localization** with a custom `AppLocalizations` wrapper.  
Language cycles: **AR → EN → MS → AR** via a single button in the AppBar.

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
│   │   ├── app_size.dart          # Spacing & radius constants
│   │   ├── app_string.dart        # Asset paths, font names, Supabase config
│   │   └── app_text_style.dart    # Typography (Inter EN + Rakkas AR)
│   ├── di/
│   │   └── injection.dart         # Manual get_it registration
│   ├── localization/
│   │   └── app_localizations.dart # Localization delegate (easy_localization)
│   └── theme/
│       └── app_theme.dart         # Light theme + Arabic theme (Rakkas font)
│
├── domain/
│   ├── entities/
│   │   ├── author.dart            # Author(id, name, imageUrl)
│   │   └── book.dart              # Book(id, title, publishedYear, authorName, imageUrl)
│   ├── repositories/
│   │   ├── i_author_repository.dart
│   │   └── i_book_repository.dart
│   └── usecases/
│       ├── get_authors_usecase.dart
│       ├── get_books_usecase.dart
│       ├── add_author_usecase.dart
│       └── add_book_usecase.dart
│
├── data/
│   ├── datasources/
│   │   ├── author_remote_datasource.dart
│   │   └── book_remote_datasource.dart    # select('*, authors(name)') JOIN
│   ├── models/
│   │   ├── author_model.dart      # fromJson / toJson
│   │   └── book_model.dart        # fromJson / toJson
│   └── repositories/
│       ├── author_repository_impl.dart
│       └── book_repository_impl.dart
│
└── presentation/
    ├── cubits/
    │   ├── authors/               # AuthorsCubit + AuthorsState
    │   ├── books/                 # BooksCubit + BooksState
    │   └── locale/                # LocaleCubit (AR → EN → MS)
    ├── screens/
    │   ├── main/                  # IndexedStack navigation
    │   ├── home/                  # Stats dashboard
    │   ├── authors/               # Authors list + add form
    │   └── books/                 # Books list + add form
    └── widgets/
        ├── common/                # GradientAppBar, GradientButton, AppTextField
        ├── nav_bar/               # AppBottomNavBar
        ├── authors/               # AuthorListItem, AddAuthorForm
        └── books/                 # BookListItem, AddBookForm
```

---

## Design

- **Primary color:** `#7C3AED` (Purple)
- **AppBar:** Purple gradient (`#7C3AED` → `#5B21B6`)
- **Fonts:** Inter (EN/MS) + Rakkas (AR)
- **Author avatars:** Colored initials fallback or network image
- **Book covers:** Colored block fallback or network image

---

## State Management Pattern

All cubits use an **enum-based status** pattern:

```dart
enum BooksStatus { initial, loading, adding, success, error }

class BooksState {
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
