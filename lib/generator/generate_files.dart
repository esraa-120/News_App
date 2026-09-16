import 'dart:io';

void main() {
  final folders = [
    'lib/core/config',
    'lib/core/routes',
    'lib/core/theme',
    'lib/modules/splash',
  ];

  final files = [
    'lib/core/config/app_config.dart',
    'lib/core/routes/app_routes_name.dart',
    'lib/core/routes/app_router.dart',
    'lib/core/theme/app_colors.dart',
    'lib/core/theme/app_theme.dart',
    'lib/modules/splash/presentation/pages/splash_page.dart',
  ];

  // Create folders
  for (final path in folders) {
    Directory(path).createSync(recursive: true);
    print('Created folder: $path');
  }

  // Create files
  for (final path in files) {
    final file = File(path);

    if (!file.existsSync()) {
      file.createSync(recursive: true);
      print('Created file: $path');
    } else {
      print('File already exists: $path');
    }
  }

  print('\nProject structure created successfully!');
}