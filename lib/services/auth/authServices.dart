import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createNewUser(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'profileCompleted': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw 'Este email já está cadastrado.';
        case 'invalid-email':
          throw 'O email inserido é inválido.';
        case 'operation-not-allowed':
          throw 'Cadastro de usuários está temporariamente desativado.';
        case 'weak-password':
          throw 'A senha é muito fraca. Use uma senha com pelo menos 6 caracteres.';
        default:
          throw 'Erro ao criar usuário. Tente novamente mais tarde.';
      }
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
    } catch (e) {
      throw e;
    }
  }
}
