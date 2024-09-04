import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_showcase/app_config.dart';
import 'package:flutter_showcase/core/rouing/app_router.dart';
import 'package:flutter_showcase/core/theme/theme.dart';
import 'package:flutter_showcase/features/onboarding/presentation/onboarding_bloc.dart';
import 'package:flutter_showcase/l10n/arb/app_localizations.dart';

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
        builder: (context, child) => MaterialApp.router(
          debugShowCheckedModeBanner:
              AppConfig.appFlavor == Flavors.development,
          //theme
          themeMode: langIndex == 0 ? ThemeMode.light : ThemeMode.dark,
          theme: AppThemeData.lightThemeData,
          darkTheme: AppThemeData.darkThemeData,
          //localization
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: AppLocalizations.supportedLocales[langIndex],
          //go_router
          routerConfig: AppRouter.getRoutes(),
        ),
      ),
    );
  }
}
