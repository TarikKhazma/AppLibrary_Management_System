// GENERATED CODE - DO NOT MODIFY BY HAND
// Run: dart tool/gen_localizations.dart

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'locale_keys.g.dart';

class AppLocalizations {
  final Locale locale;
  const AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static const LocalizationsDelegate<AppLocalizations> delegate = _Delegate();

  String get appTitle => LocaleKeys.app_title.tr();
  String get home => LocaleKeys.home.tr();
  String get books => LocaleKeys.books.tr();
  String get authors => LocaleKeys.authors.tr();
  String get addNewBook => LocaleKeys.add_new_book.tr();
  String get addNewAuthor => LocaleKeys.add_new_author.tr();
  String get enterBookTitle => LocaleKeys.enter_book_title.tr();
  String get enterPublishYear => LocaleKeys.enter_publish_year.tr();
  String get selectAuthor => LocaleKeys.select_author.tr();
  String get addBook => LocaleKeys.add_book.tr();
  String get enterAuthorName => LocaleKeys.enter_author_name.tr();
  String get addAuthor => LocaleKeys.add_author.tr();
  String get booksList => LocaleKeys.books_list.tr();
  String get authorsList => LocaleKeys.authors_list.tr();
  String get noBooks => LocaleKeys.no_books.tr();
  String get noAuthors => LocaleKeys.no_authors.tr();
  String get edit => LocaleKeys.edit.tr();
  String get delete => LocaleKeys.delete.tr();
  String get cancel => LocaleKeys.cancel.tr();
  String get save => LocaleKeys.save.tr();
  String get error => LocaleKeys.error.tr();
  String get success => LocaleKeys.success.tr();
  String get loading => LocaleKeys.loading.tr();
  String get publishYear => LocaleKeys.publish_year.tr();
  String get author => LocaleKeys.author.tr();
  String get bookAddedSuccess => LocaleKeys.book_added_success.tr();
  String get authorAddedSuccess => LocaleKeys.author_added_success.tr();
  String get bookDeletedSuccess => LocaleKeys.book_deleted_success.tr();
  String get bookUpdatedSuccess => LocaleKeys.book_updated_success.tr();
  String get authorDeletedSuccess => LocaleKeys.author_deleted_success.tr();
  String get authorUpdatedSuccess => LocaleKeys.author_updated_success.tr();
  String get fieldRequired => LocaleKeys.field_required.tr();
  String get invalidYear => LocaleKeys.invalid_year.tr();
  String get confirmDelete => LocaleKeys.confirm_delete.tr();
  String get confirmDeleteMsg => LocaleKeys.confirm_delete_msg.tr();
  String get totalBooks => LocaleKeys.total_books.tr();
  String get totalAuthors => LocaleKeys.total_authors.tr();
  String get welcome => LocaleKeys.welcome.tr();
  String get enterImageUrl => LocaleKeys.enter_image_url.tr();
  String get imageUrl => LocaleKeys.image_url.tr();
  String get search => LocaleKeys.search.tr();
  String get searchHint => LocaleKeys.search_hint.tr();
  String get noResults => LocaleKeys.no_results.tr();
  String get trash => LocaleKeys.trash.tr();
  String get restore => LocaleKeys.restore.tr();
  String get deleteForever => LocaleKeys.delete_forever.tr();
  String get daysRemaining => LocaleKeys.days_remaining.tr();
  String get emptyTrash => LocaleKeys.empty_trash.tr();
  String get deletedBooks => LocaleKeys.deleted_books.tr();
  String get deletedAuthors => LocaleKeys.deleted_authors.tr();
  String get bookRestoredSuccess => LocaleKeys.book_restored_success.tr();
  String get authorRestoredSuccess => LocaleKeys.author_restored_success.tr();
  String get bookPermanentlyDeleted => LocaleKeys.book_permanently_deleted.tr();
  String get authorPermanentlyDeleted => LocaleKeys.author_permanently_deleted.tr();
  String get libraryHub => LocaleKeys.library_hub.tr();
  String get welcomeBack => LocaleKeys.welcome_back.tr();
  String get createAccount => LocaleKeys.create_account.tr();
  String get continueWithFacebook => LocaleKeys.continue_with_facebook.tr();
  String get continueWithGoogle => LocaleKeys.continue_with_google.tr();
  String get orLoginWithEmail => LocaleKeys.or_login_with_email.tr();
  String get password => LocaleKeys.password.tr();
  String get confirmPassword => LocaleKeys.confirm_password.tr();
  String get signIn => LocaleKeys.sign_in.tr();
  String get signUp => LocaleKeys.sign_up.tr();
  String get getStarted => LocaleKeys.get_started.tr();
  String get forgotPassword => LocaleKeys.forgot_password.tr();
  String get noAccount => LocaleKeys.no_account.tr();
  String get haveAccount => LocaleKeys.have_account.tr();
  String get privacyPolicyPrefix => LocaleKeys.privacy_policy_prefix.tr();
  String get privacyPolicy => LocaleKeys.privacy_policy.tr();
  String get loginFailed => LocaleKeys.login_failed.tr();
  String get signupFailed => LocaleKeys.signup_failed.tr();
  String get passwordTooShort => LocaleKeys.password_too_short.tr();
  String get passwordsNotMatch => LocaleKeys.passwords_not_match.tr();
  String get mustAgreeToPolicy => LocaleKeys.must_agree_to_policy.tr();
  String get loginSuccess => LocaleKeys.login_success.tr();
  String get signupSuccess => LocaleKeys.signup_success.tr();
}

class _Delegate extends LocalizationsDelegate<AppLocalizations> {
  const _Delegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<AppLocalizations> old,
  ) => true;
}
