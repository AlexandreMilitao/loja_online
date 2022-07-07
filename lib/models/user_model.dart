import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? firebaseUser;

  Map<String, dynamic> userData = {};

  bool isLoading = false;

  Future singUP({
    required Map<String, dynamic> userData,
    required String pass,
    required VoidCallback onSuccess,
    required VoidCallback onFail,
  }) async {
    isLoading = true;
    notifyListeners();
    _auth
        .createUserWithEmailAndPassword(
      email: userData["email"],
      password: pass,
    )
        .then((firebaseUser) async {
      firebaseUser = firebaseUser;

      await _saveUserdata(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void singIn() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));
    isLoading = false;
    notifyListeners();
  }

  void signOut() async {
    await _auth.signOut();
    userData = {};
    firebaseUser = null;

    notifyListeners();
  }

  void recoverPass() {}

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future _saveUserdata(Map<String, dynamic> userData) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser?.uid)
        .set(userData);
    this.userData = userData;
  }
}
