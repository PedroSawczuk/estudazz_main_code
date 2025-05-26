import 'package:estudazz_main_code/firebase_options.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/theme/appTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/get_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Tenta acessar o arquivo .env
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Erro ao carregar o arquivo .env: $e");
  }

  runApp(
    GetMaterialApp(

      // -- Configurações de Localização --
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('pt', 'BR'),
      ],
      locale: Locale('pt', 'BR'), 
      
      // -- Configurações de Tema --
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: AppTheme.themeMode,
      debugShowCheckedModeBanner: false,

      // -- Configurações de Rotas --
      initialRoute: AppRoutes.homePage,
      getPages: AppRoutes.routes,
    ),
  );
}
