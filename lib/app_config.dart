import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Flavors { development, production }

class AppConfig {
  static Flavors appFlavor = Flavors.development;

  static Future<void> initialize() async {
    await dotenv.load(
      fileName: 'env/${appFlavor.name}.env',
    ); // Load environment based on flavor
  }

  static String get title {
    switch (appFlavor) {
      case Flavors.development:
        return 'dev';
      case Flavors.production:
        return 'prod';
    }
  }

  static String get baseUrl {
    // Access base URL from environment variable
    return dotenv.env['BASE_URL']!;
  }
}
