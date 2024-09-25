# flutter_showcase

A new Flutter project.

- to generate localization strings, add your tour data inside the arab folder's each language and then run `flutter gen-l10n`

- use theme for text styles and colors ... through the app using `context` instead of using `theme.of(context).textTheme`. this is meant to convert design units to flutter text theming units.

- the asset files are created via `flutter_gen` package, after adding an asset, run `fluttergen` command to update the generated `Assets` class and use it.

- environment variables are stored in root's env folder in two files: development.env and production.env each containing `BASE_URL=http://ADDRESS`
