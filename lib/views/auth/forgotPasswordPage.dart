import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signInPage.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController emailController = TextEditingController();

  void recoverPassword() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar(
        "Erro",
        "Digite um email válido.",
        backgroundColor: ConstColors.redColor,
        colorText: ConstColors.whiteColor,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Sucesso",
        "Email de recuperação enviado! Verifique sua caixa de entrada.",
        backgroundColor: ConstColors.greenColor,
        colorText: ConstColors.whiteColor,
      );
      Get.offAllNamed(AppRoutes.signInPage);
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case 'user-not-found':
          message = "Usuário não encontrado com este email.";
          break;
        case 'invalid-email':
          message = "Email inválido.";
          break;
        default:
          message = "Erro ao enviar email de recuperação.";
      }
      Get.snackbar(
        "Erro",
        message,
        backgroundColor: ConstColors.redColor,
        colorText: ConstColors.whiteColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.blackColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'RECUPERAR CONTA',
                style: TextStyle(
                  color: ConstColors.whiteColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.grey[900],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: ConstColors.whiteColor),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Get.offAll(() => SignInPage());
                  },
                  child: Text(
                    'Voltar ao login',
                    style: TextStyle(color: ConstColors.greyColor),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: recoverPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ConstColors.orangeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    'Recuperar',
                    style: TextStyle(
                      color: ConstColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
