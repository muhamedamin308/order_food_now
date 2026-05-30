import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:order_now/core/constants/app_colors.dart';
import 'package:order_now/features/auth/presentation/pages/login_page.dart';
import 'package:order_now/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.indigo),
        splashColor: AppColors.transparent,
      ),
      home: LoginPage(),
    );
  }
}
