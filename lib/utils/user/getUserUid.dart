import 'package:firebase_auth/firebase_auth.dart';

class GetUserUid {
  static Future<String?> getUserUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }
}