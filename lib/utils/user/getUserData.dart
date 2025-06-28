import 'package:firebase_auth/firebase_auth.dart';

class GetUserData {
  static Future<String?> getUserUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  static Future<String?> getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.email;
  }
}