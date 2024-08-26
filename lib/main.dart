import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_showcase/core/theme/theme.dart';
import 'package:flutter_showcase/l10n/arb/app_localizations.dart';
import 'package:flutter_showcase/l10n/ln10.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int langIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: langIndex == 0 ? ThemeMode.dark : ThemeMode.light,
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: AppLocalizations.supportedLocales[langIndex],
      home: Scaffold(
        body: Center(
          child: Builder(
            builder: (cntxt) {
              return CupertinoButton(
                color: Theme.of(cntxt).primaryColor,
                onPressed: () {
                  setState(
                    () {
                      langIndex = (langIndex == 0 ? 1 : 0);
                    },
                  );
                },
                child: Text(
                  cntxt.l10n.language,
                  style: Theme.of(cntxt).textTheme.titleLarge,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
