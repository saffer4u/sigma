import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _authInstence = FirebaseAuth.instance;

  String get getUid => _authInstence.currentUser!.uid;

  Future<void> logOut() async => await _authInstence.signOut();

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

  Future<void> login({required String email, required String password}) async {
    try {
      final credential = await _authInstence.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ('Wrong password provided for that user.');
      }
    }
  }
}
