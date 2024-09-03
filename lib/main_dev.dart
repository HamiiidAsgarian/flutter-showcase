import 'package:flutter/material.dart';
import 'package:flutter_showcase/app_config.dart';
import 'package:flutter_showcase/my_app.dart';

///flutter run -t lib/main_prod.dart
void main() {
  AppConfig.appFlavor = Flavors.development;
  runApp(const MainApp());
}
