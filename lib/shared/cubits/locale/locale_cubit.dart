import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'locale_state.dart';

@lazySingleton
class LocaleCubit extends Cubit<LocaleState> {
  static const _langs = ['ar', 'en', 'ms'];

  LocaleCubit() : super(const LocaleState(Locale('ar')));

  void cycleLanguage(BuildContext context) {
    final current = context.locale.languageCode;
    final idx = _langs.indexOf(current);
    final next = _langs[(idx + 1) % _langs.length];
    setLanguage(context, next);
  }

  void setLanguage(BuildContext context, String langCode) {
    final newLocale = Locale(langCode);
    context.setLocale(newLocale);
    emit(LocaleState(newLocale));
  }
}
