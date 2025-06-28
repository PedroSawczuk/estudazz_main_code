import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/utils/user/getUserData.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  final _firestore = FirebaseFirestore.instance;

  RxBool profileCompleted = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkProfileCompleted();
  }

  Future<void> checkProfileCompleted() async {
    final uid = await GetUserData.getUserUid();
    if (uid == null) return;

    final snapshot = await _firestore.collection('users').doc(uid).get();
    if (snapshot.exists) {
      profileCompleted.value = snapshot.data()?['profileCompleted'] ?? false;
    }
  }
}
