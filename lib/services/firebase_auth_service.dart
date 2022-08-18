import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _authInstence = FirebaseAuth.instance;

  String get getUid => _authInstence.currentUser!.uid;

  void logOut() => _authInstence.signOut();

  Stream<User?> getCurrentUser() => _authInstence.userChanges();

  Future<void> signUp({required String email, required String password}) async {
    try {
      final credential = await _authInstence.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
