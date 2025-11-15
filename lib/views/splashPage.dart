import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final lastActivity = prefs.getInt('lastActivity');
    final now = DateTime.now().millisecondsSinceEpoch;

    if (lastActivity != null) {
      final thirtyDaysInMillis = 30 * 24 * 60 * 60 * 1000;
      if (now - lastActivity > thirtyDaysInMillis) {
        await FirebaseAuth.instance.signOut();
        await prefs.clear();
        Get.offAllNamed(AppRoutes.signInPage);
        return;
      }
    }

    await prefs.setInt('lastActivity', now);

    if (FirebaseAuth.instance.currentUser != null) {
      Get.offAllNamed(AppRoutes.homePage);
    } else {
      Get.offAllNamed(AppRoutes.signInPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
