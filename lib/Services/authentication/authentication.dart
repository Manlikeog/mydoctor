import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/toast.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;

  User? get user => auth.currentUser;

  Future<void> loginIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      showToasterror(error.toString());
    }
  }

  Future<void> signup(String email, String password, String username) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await user!.updateDisplayName(username);
    } on FirebaseAuthException catch (error) {
      showToasterror(error.toString());
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (error) {
      showToasterror(error.toString());
    }
  }

  Future<void> verifyPassword(String code) async {
    try {
      await auth.verifyPasswordResetCode(code);
    } on FirebaseAuthException catch (error) {
      showToasterror(error.toString());
    }
  }

  Future<void> confirmPassword(String code, String newpassword) async {
    try {
      await auth.confirmPasswordReset(code: code, newPassword: newpassword);
    } on FirebaseAuthException catch (error) {
      showToasterror(error.toString());
    }
  }

  Future<void> signout() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (error) {
      showToasterror(error.toString());
    }
  }
}
