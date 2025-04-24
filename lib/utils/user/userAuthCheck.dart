import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthGuard {
  static Future<void> handleAuthenticatedAction({
    required BuildContext context,
    required VoidCallback onAuthenticated,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      _showLoginRequiredDialog(context);
    } else {
      onAuthenticated();
    }
  }

  static void _showLoginRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Você não está autenticado!"),
            content: Text("Para ter uma experiência completa, faça login."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Get.toNamed(AppRoutes.signInPage);
                },
                child: Text("Entrar"),
              ),
            ],
          ),
    );
  }
}
