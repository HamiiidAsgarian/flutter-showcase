enum Flavors { development, production }

class AppConfig {
  static Flavors appFlavor = Flavors.development;

  static String get title {
    switch (appFlavor) {
      case Flavors.development:
        return 'dev';

      case Flavors.production:
        return 'prod';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavors.development:
        return 'https://dev.domain.com/api/v1';

      case Flavors.production:
        return 'https://domain.com/api/v1';
    }
  }
}
