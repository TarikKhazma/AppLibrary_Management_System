import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  const AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static const LocalizationsDelegate<AppLocalizations> delegate = _Delegate();

  String get appTitle => 'app_title'.tr();
  String get home => 'home'.tr();
  String get books => 'books'.tr();
  String get authors => 'authors'.tr();
  String get addNewBook => 'add_new_book'.tr();
  String get addNewAuthor => 'add_new_author'.tr();
  String get enterBookTitle => 'enter_book_title'.tr();
  String get enterPublishYear => 'enter_publish_year'.tr();
  String get selectAuthor => 'select_author'.tr();
  String get addBook => 'add_book'.tr();
  String get enterAuthorName => 'enter_author_name'.tr();
  String get addAuthor => 'add_author'.tr();
  String get booksList => 'books_list'.tr();
  String get authorsList => 'authors_list'.tr();
  String get noBooks => 'no_books'.tr();
  String get noAuthors => 'no_authors'.tr();
  String get edit => 'edit'.tr();
  String get delete => 'delete'.tr();
  String get cancel => 'cancel'.tr();
  String get save => 'save'.tr();
  String get error => 'error'.tr();
  String get success => 'success'.tr();
  String get loading => 'loading'.tr();
  String get publishYear => 'publish_year'.tr();
  String get author => 'author'.tr();
  String get bookAddedSuccess => 'book_added_success'.tr();
  String get authorAddedSuccess => 'author_added_success'.tr();
  String get bookDeletedSuccess => 'book_deleted_success'.tr();
  String get authorDeletedSuccess => 'author_deleted_success'.tr();
  String get fieldRequired => 'field_required'.tr();
  String get invalidYear => 'invalid_year'.tr();
  String get confirmDelete => 'confirm_delete'.tr();
  String get confirmDeleteMsg => 'confirm_delete_msg'.tr();
  String get totalBooks => 'total_books'.tr();
  String get totalAuthors => 'total_authors'.tr();
  String get welcome => 'welcome'.tr();
  String get enterImageUrl => 'enter_image_url'.tr();
  String get imageUrl => 'image_url'.tr();
}

class _Delegate extends LocalizationsDelegate<AppLocalizations> {
  const _Delegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      true;
}
