import 'package:flutter/material.dart';
import 'package:news_app/core/providers/settings_provider.dart';
import 'package:news_app/core/routes/app_router.dart';
import 'package:provider/provider.dart';
import 'core/l10n/app_localizations.dart';
import 'core/routes/app_routes_name.dart';
import 'core/theme/app_theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => SettingsProvider(),
      child: const MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

  final vm = Provider.of<SettingsProvider>(context);
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "News App",
    theme: AppTheme.light(),
    navigatorKey: navigatorKey,
      locale: Locale(vm.currentLanguage),
    initialRoute: AppRoutesName.initial,
    onGenerateRoute: AppRouter.onGenerateRoute,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales
  );
}
}