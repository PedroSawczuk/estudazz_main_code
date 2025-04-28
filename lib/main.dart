import 'package:estudazz_main_code/firebase_options.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/theme/appTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/get_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('pt', 'BR'),
      ],
      locale: Locale('pt', 'BR'), 
      
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: AppTheme.themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homePage,
      getPages: AppRoutes.routes,
    ),
  );
}
