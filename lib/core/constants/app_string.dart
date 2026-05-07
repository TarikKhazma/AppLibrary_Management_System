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

  // Supabase config - replace with your actual credentials
  static const String supabaseUrl = 'https://yjwjvsufssdefwwxajej.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlqd2p2c3Vmc3NkZWZ3d3hhamVqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzgwMDk0NTQsImV4cCI6MjA5MzU4NTQ1NH0.QN9ZiWiFD4hi7E0_5pAOiiR61Ew3FB6hgwu4JMIFdug';

  // Supabase table names
  static const String authorsTable = 'authors';
  static const String booksTable = 'books';
}
