import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/models/user/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  Future<UserModel?> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final uid = user.uid;
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (doc.exists) {
        return UserModel.fromMap(doc.data()!, uid);
      }
    }

    return null;
  }
}
