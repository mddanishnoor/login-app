import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_app/screens/loginScreen.dart';

class Authentication extends ChangeNotifier {
  String _uid;
  String _email;

  String get getUid => _uid;
  String get getEmail => _email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut(BuildContext context) {
    _auth.signOut();
  }

  Future<bool> signUpUser(
      String email, String password, BuildContext context) async {
    bool returnVal = false;

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        _uid = userCredential.user.uid;
        _email = userCredential.user.email;
        error = null;
        returnVal = true;
      }
    } catch (e) {
      if (e.code == 'email-already-in-use') {
        error = 'E-mail already exists';
      }
      print(e);
    }
    return returnVal;
  }

  Future<bool> loginUser(
      String email, String password, BuildContext context) async {
    bool returnVal = false;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user != null) {
        _uid = userCredential.user.uid;
        _email = userCredential.user.email;
        error = null;
        returnVal = true;
      }
    } catch (e) {
      if (e.code == 'wrong-password') {
        error = 'Incorrect Password';
      } else if (e.code == 'user-not-found') {
        error = 'User not found';
      }
      print(e);
    }

    return returnVal;
  }
}
