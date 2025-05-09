import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/images_manager.dart';
import 'package:flutter_application_1/splash/screen/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
    ).then(
      (_) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const WelcomeScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(ImagesManager.logo),
      ),
    );
  }
}
