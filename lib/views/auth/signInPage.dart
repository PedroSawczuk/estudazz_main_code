import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/controllers/auth/authController.dart';
import 'package:estudazz_main_code/utils/validators/TextFieldValidator.dart';
import 'package:estudazz_main_code/views/auth/forgotPasswordPage.dart';
import 'package:estudazz_main_code/views/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signUpPage.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = AuthController();
  bool _isPasswordVisible = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.toLowerCase();
      String password = _passwordController.text;

      CustomSnackBar.show(
        title: 'Aguarde',
        message: 'Entrando...',
        backgroundColor: ConstColors.orangeColor,
      );

      try {
        await _authController.signIn(email, password);
        Get.offAll(() => HomePage());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          CustomSnackBar.show(
            title: 'Erro!',
            message: 'Usuário não encontrado',
            backgroundColor: ConstColors.redColor,
          );
        } else if (e.code == 'invalid-credential') {
          CustomSnackBar.show(
            title: 'Erro!',
            message: 'Verifique se seu email ou senha estão corretos',
            backgroundColor: ConstColors.redColor,
          );
        } else if (e.code == 'user-disabled') {
          CustomSnackBar.show(
            title: 'Erro!',
            message: 'Essa conta foi desativada',
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'ENTRAR',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                ConstSizedBox.h30,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator:
                        (value) =>
                            textFieldValidator(value, 'Email é obrigatório'),
                  ),
                ),
                ConstSizedBox.h10,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator:
                        (value) =>
                            textFieldValidator(value, 'Senha é obrigatória'),
                  ),
                ),
                ConstSizedBox.h10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.offAll(() => ForgotPasswordPage());
                      },
                      child: Text(
                        'Esqueci minha senha',
                        style: TextStyle(color: ConstColors.greyColor),
                      ),
                    ),
                  ],
                ),
                ConstSizedBox.h5,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Não tem uma conta?'),
                      TextButton(
                        onPressed: () {
                          Get.offAll(() => SignUpPage());
                        },
                        child: Text('Crie aqui'),
                      ),
                    ],
                  ),
                ),
                ConstSizedBox.h10,
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(200, 44),
                    backgroundColor: ConstColors.orangeColor,
                    foregroundColor: ConstColors.whiteColor,
                  ),
                  child: Text('Entrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
