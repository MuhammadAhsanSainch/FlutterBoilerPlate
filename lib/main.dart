import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterboilerplate/screens/login/login_binding.dart';
import 'package:flutterboilerplate/themes/app_globals.dart';
import 'package:flutterboilerplate/themes/app_theme.dart';
import 'package:get/get.dart';

import 'screens/splash.dart';

void main() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..boxShadow = <BoxShadow>[]
    ..progressColor = Colors.white
    ..backgroundColor = AppThemes.primaryColor
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.black.withOpacity(0.7)
    ..userInteractions = false
    ..dismissOnTap = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Boiler Plate',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      builder: EasyLoading.init(),
      home: const SplashScreen(),
      navigatorKey: AppGlobals.appNavigationKey,
    );
  }
}