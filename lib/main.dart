import 'package:estudazz_main_code/env.dart';
import 'package:estudazz_main_code/firebase_options.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/theme/appTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Gemini.init(apiKey: Env.geminiApiKey);

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(Env.iaChatStorageKey);
  OneSignal.Notifications.requestPermission(true);

  runApp(
    GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      locale: const Locale('pt', 'BR'),

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: AppTheme.themeMode,
      debugShowCheckedModeBanner: false,

      initialRoute: AppRoutes.homePage,
      getPages: AppRoutes.routes,
    ),
  );
}
