import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qutoes_app/core/di.dart';
import 'package:qutoes_app/core/shared_prefrance.dart';
import 'package:qutoes_app/core/theme/dark_theme.dart';
import 'package:qutoes_app/core/theme/light_theme.dart';
import 'package:qutoes_app/feature/auth/controller/auth_provider.dart';

import 'package:qutoes_app/feature/home/ui/home.dart';

import 'package:qutoes_app/feature/auth/ui/login_screen.dart';
import 'package:qutoes_app/feature/auth/ui/signup.dart';
import 'package:qutoes_app/feature/splash/ui/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  ServiceLocator.init();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/localization',
      fallbackLocale: const Locale('ar'),
      child: MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: LightAppTheme.themeData,
      darkTheme: DarkAppTheme.themeData,
      themeMode: ThemeMode.light,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),

        '/home': (context) => const Home(),
      },
    );
  }
}
