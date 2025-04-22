import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePageController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  RxBool profileCompleted = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkProfileCompleted();
  }

  Future<void> checkProfileCompleted() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      profileCompleted.value = doc.data()?['profileCompleted'] ?? false;
    }
  }
}
