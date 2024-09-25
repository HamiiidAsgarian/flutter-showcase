import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_showcase/app_config.dart';
import 'package:flutter_showcase/core/rouing/app_router.dart';
import 'package:flutter_showcase/core/theme/theme.dart';
import 'package:flutter_showcase/l10n/arb/app_localizations.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _langIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      fontSizeResolver: FontSizeResolvers.radius,
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: AppConfig.appFlavor == Flavors.development,
        //theme
        themeMode: _langIndex == 0 ? ThemeMode.light : ThemeMode.dark,
        theme: AppThemeData.lightThemeData,
        darkTheme: AppThemeData.darkThemeData,
        //localization
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: AppLocalizations.supportedLocales[_langIndex],
        //go_router
        routerConfig: AppRouter.getRoutes(),
      ),
    );
  }
}
