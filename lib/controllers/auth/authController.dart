import 'package:estudazz_main_code/services/auth/authServices.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final AuthServices _authServices = AuthServices();

  Future<void> signUp(String email, String password) async {
    try {
      await _authServices.createNewUser(email, password);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _authServices.loginUser(email, password);
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        OneSignal.login(user.uid);
      }
    } catch (e) {
      throw e;
    }
  }
}