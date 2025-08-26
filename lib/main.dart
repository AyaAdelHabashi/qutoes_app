import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qutoes_app/core/theme/dark_theme.dart';
import 'package:qutoes_app/core/theme/light_theme.dart';
import 'package:qutoes_app/feature/login/ui/home/ui/home.dart';
import 'package:qutoes_app/feature/login/ui/login_screen.dart';
import 'package:qutoes_app/feature/login/ui/signup.dart';
import 'package:qutoes_app/feature/splash/ui/splash_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [ Locale('ar')],
      path: 'assets/localization',
      fallbackLocale: const Locale('ar'),
      child: const MyApp(),
    ),
  );}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen() ,
      theme: LightAppTheme.themeData,
      darkTheme: DarkAppTheme.themeData,
      themeMode: ThemeMode.light,
      locale: context.locale,                 // يثبت اللغة على العربية
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup' :(context)=> SignupScreen(),
        '/home':(context) => Home(),},
    );
  }
}


