import 'package:flutter/material.dart';
import 'package:news_app/core/routes/app_routes_name.dart';
import 'package:news_app/gen/assets.gen.dart';
import 'package:news_app/main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(AppRoutesName.home, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Assets.images.newsLogoImg.image()),
    );
  }
}
