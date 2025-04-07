import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/theme/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(
    GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: AppTheme.themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homePage,
      getPages: AppRoutes.routes,
    ),
  );
}
