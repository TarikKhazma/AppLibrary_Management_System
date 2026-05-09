import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/app_string.dart';
import 'core/di/injection.dart';
import 'core/localization/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/cubits/auth_cubit.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/locale/locale_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Supabase.initialize(
    url: AppString.supabaseUrl,
    anonKey: AppString.supabaseAnonKey,
  );

  await configureDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en'), Locale('ms')],
      path: 'assets/translations',
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      saveLocale: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<LocaleCubit>()),
          BlocProvider(create: (_) => getIt<AuthCubit>()),
        ],
        child: DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) => const LibraryApp(),
        ),
      ),
    ),
  );
}

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library Management System',
      debugShowCheckedModeBanner: false,
      theme: context.locale.languageCode == 'ar'
          ? AppTheme.arabicTheme
          : AppTheme.lightTheme,
      locale: context.locale,
      builder: DevicePreview.appBuilder,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: [
        AppLocalizations.delegate,
        ...context.localizationDelegates,
      ],
      home: const SplashScreen(),
    );
  }
}
