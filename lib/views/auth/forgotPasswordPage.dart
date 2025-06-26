import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'signInPage.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController emailController = TextEditingController();

  void recoverPassword() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      CustomSnackBar.show(
        title: 'Erro!',
        message: 'Email não pode ser vazio.',
        backgroundColor: ConstColors.redColor,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      CustomSnackBar.show(
        title: 'Sucesso',
        message:
            'Email de recuperação enviado! Verifique sua caixa de entrada.',
        backgroundColor: ConstColors.greenColor,
      );
      Get.offAllNamed(AppRoutes.signInPage);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomSnackBar.show(
          title: 'Erro!',
          message: 'Usuário não encontrado com este email',
          backgroundColor: ConstColors.redColor,
        );
      } else if (e.code == 'invalid-email') {
        CustomSnackBar.show(
          title: 'Erro!',
          message: 'Email inválido',
          backgroundColor: ConstColors.redColor,
        );
      } else {
        CustomSnackBar.show(
          title: 'Erro Inesperado',
          message: 'Erro ao entrar, contate o suporte',
          backgroundColor: ConstColors.redColor,
        );
      }
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
              ConstSizedBox.h32,
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: ConstColors.white54Color),
                  filled: true,
                  fillColor: ConstColors.grey900Color,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: ConstColors.whiteColor),
              ),
              ConstSizedBox.h16,
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
              ConstSizedBox.h16,
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
