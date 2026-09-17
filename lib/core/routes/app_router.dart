import 'package:flutter/material.dart';
import 'package:news_app/modules/home/view_model/home_view_model.dart';
import 'package:news_app/modules/home/views/home_page.dart';
import 'package:news_app/modules/splash/presentation/pages/splash_page.dart';
import 'package:provider/provider.dart';

import 'app_routes_name.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.initial:
        return MaterialPageRoute(
          builder: (context) => const SplashPage(),
        );
        case AppRoutesName.home:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<HomeViewModel>
            (create: (context) => HomeViewModel(),
              child: HomePage()),
        );
        default:
          return MaterialPageRoute(
            builder: (context) => Scaffold(),
          );
    }
  }
}