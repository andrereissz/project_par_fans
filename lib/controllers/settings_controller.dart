import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingsController extends GetxController {
  final usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  Future<void> updateUsername(String newUsername) async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;

      if (currentUserId == null) {
        showToast("User not logged in.", Colors.red);
        return;
      }

      // Busca o documento pelo campo `id`
      final userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: currentUserId)
          .limit(1)
          .get();

      if (userQuery.docs.isEmpty) {
        showToast("User document not found.", Colors.red);
        return;
      }

      final userDoc = userQuery.docs.first.reference;

      // Verifica se o username já existe
      final existingUser = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: newUsername)
          .get();

      if (existingUser.docs.isNotEmpty) {
        showToast("Username already taken.", Colors.red);
        return;
      }

      // Atualiza o username na coleção `users`
      await userDoc.update({'username': newUsername});

      // Atualiza o username nos reviews
      final reviews = await FirebaseFirestore.instance
          .collection('reviews')
          .where('reviewerId', isEqualTo: currentUserId)
          .get();

      for (var review in reviews.docs) {
        await review.reference.update({'reviewerUsername': newUsername});
      }

      showToast("Username updated successfully.", Colors.green);
    } catch (e) {
      showToast("Failed to update username: $e", Colors.red);
    }
  }

  Future<void> deleteAccount({required String email}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        showToast("User not logged in.", Colors.red);
        return;
      }

      final currentUserId = user.uid;

      // Busca o documento pelo campo `id`
      final userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: currentUserId)
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (userQuery.docs.isEmpty) {
        showToast("This provided email is incorrect.", Colors.red);
        return;
      }

      final userDoc = userQuery.docs.first.reference;

      // Remove usuário da coleção `users`
      await userDoc.delete();

      // Remove reviews do usuário
      final reviews = await FirebaseFirestore.instance
          .collection('reviews')
          .where('reviewerId', isEqualTo: currentUserId)
          .get();

      for (var review in reviews.docs) {
        await review.reference.delete();
      }

      // Remove relações do usuário na coleção `network`
      final networkRelations = await FirebaseFirestore.instance
          .collection('network')
          .where('uidUser', isEqualTo: currentUserId)
          .get();

      for (var relation in networkRelations.docs) {
        await relation.reference.delete();
      }

      final followedRelations = await FirebaseFirestore.instance
          .collection('network')
          .where('uidFollows', isEqualTo: currentUserId)
          .get();

      for (var relation in followedRelations.docs) {
        await relation.reference.delete();
      }

      // Exclui a conta do Firebase Authentication
      await user.delete();

      Get.offAllNamed('/login');
      showToast("Account deleted successfully.", Colors.green);
    } catch (e) {
      showToast("Failed to delete account: $e", Colors.red);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/login');
  }

  void showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
