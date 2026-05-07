// Run: dart tool/gen_localizations.dart
// 1. Generates locale_keys.g.dart via easy_localization's built-in generator
// 2. Generates app_localizations.dart using those keys

import 'dart:convert';
import 'dart:io';

const _keysFile = 'lib/core/localization/locale_keys.g.dart';
const _outputFile = 'lib/core/localization/app_localizations.dart';
const _jsonFile = 'assets/translations/en.json';

void main() {
  // Step 1: run easy_localization's generator
  stderr.writeln('→ Generating locale_keys.g.dart...');
  final gen = Process.runSync('dart', [
    'run',
    'easy_localization:generate',
    '-f', 'keys',
    '-o', 'locale_keys.g.dart',
    '-S', 'assets/translations',
  ]);

  if (gen.exitCode != 0) {
    stderr.writeln('Error: ${gen.stderr}');
    exit(1);
  }

  // Move generated file from lib/generated/ to lib/core/localization/
  final generated = File('lib/generated/locale_keys.g.dart');
  if (generated.existsSync()) {
    generated.copySync(_keysFile);
    Directory('lib/generated').deleteSync(recursive: true);
  }

  // Step 2: read JSON keys
  final json = jsonDecode(
    File(_jsonFile).readAsStringSync(),
  ) as Map<String, dynamic>;

  // Step 3: generate AppLocalizations using LocaleKeys constants
  final buf = StringBuffer()
    ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
    ..writeln('// Run: dart tool/gen_localizations.dart')
    ..writeln()
    ..writeln("import 'package:easy_localization/easy_localization.dart';")
    ..writeln("import 'package:flutter/material.dart';")
    ..writeln("import 'locale_keys.g.dart';")
    ..writeln()
    ..writeln('class AppLocalizations {')
    ..writeln('  final Locale locale;')
    ..writeln('  const AppLocalizations(this.locale);')
    ..writeln()
    ..writeln('  static AppLocalizations of(BuildContext context) =>')
    ..writeln('      Localizations.of<AppLocalizations>(context, AppLocalizations)!;')
    ..writeln()
    ..writeln('  static const LocalizationsDelegate<AppLocalizations> delegate = _Delegate();')
    ..writeln();

  for (final key in json.keys) {
    buf.writeln('  String get ${_camel(key)} => LocaleKeys.$key.tr();');
  }

  buf
    ..writeln('}')
    ..writeln()
    ..writeln('class _Delegate extends LocalizationsDelegate<AppLocalizations> {')
    ..writeln('  const _Delegate();')
    ..writeln()
    ..writeln('  @override')
    ..writeln('  bool isSupported(Locale locale) => true;')
    ..writeln()
    ..writeln('  @override')
    ..writeln('  Future<AppLocalizations> load(Locale locale) async =>')
    ..writeln('      AppLocalizations(locale);')
    ..writeln()
    ..writeln('  @override')
    ..writeln('  bool shouldReload(')
    ..writeln('    covariant LocalizationsDelegate<AppLocalizations> old,')
    ..writeln('  ) => true;')
    ..writeln('}');

  File(_outputFile).writeAsStringSync(buf.toString());

  stderr.writeln('→ Generated app_localizations.dart — ${json.length} keys');
}

String _camel(String snake) {
  final parts = snake.split('_');
  return parts[0] +
      parts.skip(1).map((p) => p[0].toUpperCase() + p.substring(1)).join();
}
