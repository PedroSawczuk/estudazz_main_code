import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/controllers/auth/authController.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:estudazz_main_code/utils/validators/TextFieldValidator.dart';
import 'package:estudazz_main_code/views/auth/signInPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
        message: 'Estamos criando sua conta...',
        backgroundColor: ConstColors.orangeColor,
      );

      try {
        await _authController.signUp(email, password);
        Get.offAndToNamed(AppRoutes.signInPage);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          CustomSnackBar.show(
            title: 'Erro!',
            message: 'Esse email já está sendo usado. Tente outro',
            backgroundColor: ConstColors.redColor,
          );
        } else if (e.code == 'invalid-email') {
          CustomSnackBar.show(
            title: 'Erro!',
            message: 'Email inválido. Digite um email válido',
            backgroundColor: ConstColors.redColor,
          );
        } else if (e.code == 'weak-password') {
          CustomSnackBar.show(
            title: 'Erro!',
            message: 'A senha deve ter pelo menos 6 caracteres',
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
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'REGISTRAR',
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
                            textFieldValidator(value, 'A email é obrigatório'),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Já tem uma conta?'),
                      TextButton(
                        onPressed: () {
                          Get.offAll(() => SignInPage());
                        },
                        child: Text('Entre aqui'),
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
                  child: Text('Criar Conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
