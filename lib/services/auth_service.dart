import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      var usernameSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (usernameSnapshot.docs.isNotEmpty) {
        Fluttertoast.showToast(
          msg: "Username is already taken. Please choose another one.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
        );
        return;
      }

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      CollectionReference usersRef =
          FirebaseFirestore.instance.collection('users');

      usersRef.add({
        'username': username,
        'email': email,
        'id': uid,
      });

      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      } else {
        message = e.code;
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
      );
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'The provided email is not valid.';
      } else if (e.code == 'invalid-credential') {
        message = 'The provided user/password is incorrect.';
      } else {
        message = e.code;
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
      );
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/login');
  }
}
