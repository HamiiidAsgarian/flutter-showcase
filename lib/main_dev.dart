import 'package:flutter/material.dart';
import 'package:flutter_showcase/app_config.dart';
import 'package:flutter_showcase/core/di/get_it.dart';
import 'package:flutter_showcase/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.appFlavor = Flavors.development;
  await AppConfig.initialize();
  await setupLocator();

  runApp(const MainApp());
}
