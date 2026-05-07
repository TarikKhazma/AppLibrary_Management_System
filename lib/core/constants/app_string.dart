import 'env.dart';

class AppString {
  AppString._();

  // Font families
  static const String fontFamilyEn = 'Inter';
  static const String fontFamilyAr = 'Rakkas';

  // Asset paths - icons
  static const String authorIcon = 'assets/images/icons/author_icon.svg';
  static const String bookIcon = 'assets/images/icons/book_icon.svg';
  static const String calendarIcon = 'assets/images/icons/calendar_icon.svg';
  static const String dropdownIcon = 'assets/images/icons/dropdown_icon.svg';
  static const String addIcon = 'assets/images/icons/add_icon.svg';

  // Supabase config - loaded from env.dart (gitignored)
  static const String supabaseUrl = kSupabaseUrl;
  static const String supabaseAnonKey = kSupabaseAnonKey;

  // Supabase table names
  static const String authorsTable = 'authors';
  static const String booksTable = 'books';
}
