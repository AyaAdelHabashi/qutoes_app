import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qutoes_app/core/shared_prefrance.dart';
import 'package:qutoes_app/core/theme/colors.dart';
// لو عندك GoRouter أو Navigator لازم تعدلي هنا حسب المشروع

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (CacheHelper.getData(key: "token") != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.background,
      body: Center(child: SvgPicture.asset('assets/images/logo.svg', width: 150, height: 150)),
    );
  }
}
