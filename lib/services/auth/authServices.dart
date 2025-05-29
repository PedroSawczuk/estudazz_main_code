import 'package:estudazz_main_code/services/auth/saveUserLocal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createNewUser(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user!;

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'profileCompleted': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await SaveUserLocal.saveUser(user);

    } on FirebaseException catch (e) {
      throw "Erro ao salvar no Firestore: ${e.message}";
    } catch (e) {
      throw "Erro desconhecido: $e";
    }
  }

    Future<void> loginUser(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (_firebaseAuth.currentUser != null) {
        final user = _firebaseAuth.currentUser!;
        await SaveUserLocal.saveUser(user);
      }
    } catch (e) {
      throw e;
    }
  }
}
