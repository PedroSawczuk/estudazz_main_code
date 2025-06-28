import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/models/user/userModel.dart';
import 'package:estudazz_main_code/utils/user/getUserData.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  Future<UserModel?> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final uid = await GetUserData.getUserUid();

      final snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.exists) {
        return UserModel.fromMap(snapshot.data()!, uid!);
      }
    }

    return null;
  }
}
