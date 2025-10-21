import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/utils/user/getUserData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FetchUserDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  Future<DocumentSnapshot> getUserData() async {
    String uid = await GetUserData.getUserUid() ?? '';
    return await _firestore.collection('users').doc(uid).get();
  }

  Future<String?> uploadProfileImageAndSaveUrl(ImageSource source) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final XFile? pickedFile = await _picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile == null) return null; // User cancelled picking

    final File imageFile = File(pickedFile.path);
    final String uid = user.uid;
    final String filePath = 'users/$uid/profile.jpg';

    try {
      // Upload image to Firebase Storage
      final UploadTask uploadTask = _storage.ref().child(filePath).putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      // Save download URL to Firestore user document
      await _firestore.collection('users').doc(uid).set(
        {'photoURL': downloadUrl},
        SetOptions(merge: true),
      );

      return downloadUrl;
    } catch (e) {
      print('Error uploading profile image: $e');
      return null;
    }
  }
}
