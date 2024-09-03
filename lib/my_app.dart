import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_showcase/core/theme/theme.dart';
import 'package:flutter_showcase/l10n/arb/app_localizations.dart';
import 'package:flutter_showcase/onboarding/presentation/onboarding_bloc.dart';
import 'package:flutter_showcase/onboarding/presentation/onboarding_screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int langIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingBloc(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        fontSizeResolver: FontSizeResolvers.radius,
        builder: (context, child) => MaterialApp(
          themeMode: langIndex == 0 ? ThemeMode.dark : ThemeMode.light,
          theme: AppThemeData.lightThemeData,
          darkTheme: AppThemeData.darkThemeData,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: AppLocalizations.supportedLocales[langIndex],
          home: const OnBoardingScreen(),
        ),
      ),
    );
  }
}
