import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? firebaseUser;

  Map<String, dynamic> userData = {};

  bool isLoading = false;

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  Future singUP({
    required Map<String, dynamic> userData,
    required String pass,
    required VoidCallback onSuccess,
    required VoidCallback onFail,
  }) async {
    isLoading = true;
    notifyListeners();
    await _auth
        .createUserWithEmailAndPassword(
      email: userData["email"],
      password: pass,
    )
        .then((user) {
      firebaseUser = user.user;
      _saveUserdata(userData, user);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void singIn(
      {required String email,
      required String pass,
      required VoidCallback onSuccess,
      required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    await _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) async {
      firebaseUser = user.user;
      onSuccess();
      await _loadCurrentUser();
      isLoading = false;
      //notifyListeners();
    }).catchError((e) {});
    onFail();
    isLoading = false;
    notifyListeners();
  }

  void signOut() async {
    await _auth.signOut();
    userData = {};
    firebaseUser = null;

    notifyListeners();
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future _saveUserdata(
      Map<String, dynamic> userData, UserCredential user) async {
    this.userData = userData;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.user?.uid)
        .set(userData);
  }

  Future _loadCurrentUser() async {
    if (firebaseUser == null) {
      firebaseUser = await _auth.currentUser;
    }
    if (firebaseUser != null) {
      if (userData['name'] == null) {
        DocumentSnapshot docUser = await FirebaseFirestore.instance
            .collection("users")
            .doc(firebaseUser!.uid)
            .get();
        //print('${docUser.data()}  docUser');

        this.userData = docUser.data() as Map<String, dynamic>;
        //print('${this.userData} userData');
      }
    }
    notifyListeners();
  }
}
