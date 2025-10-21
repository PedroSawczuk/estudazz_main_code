import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/models/user/userModel.dart';
import 'package:estudazz_main_code/services/user/fetchUserDataService.dart';
import 'package:estudazz_main_code/utils/user/getUserData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class UserController {
  final FetchUserDataService _fetchUserDataService = FetchUserDataService();

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

  Future<String?> updateProfilePicture(ImageSource source) async {
    try {
      final String? photoUrl = await _fetchUserDataService.uploadProfileImageAndSaveUrl(source);
      return photoUrl;
    } catch (e) {
      print('Error updating profile picture: $e');
      return null;
    }
  }
}
