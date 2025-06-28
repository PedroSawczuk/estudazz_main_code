import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/utils/user/getUserData.dart';

class FetchUserDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUserData() async {
    String uid = await GetUserData.getUserUid() ?? '';
    return await _firestore.collection('users').doc(uid).get();
  }
}
