import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreatePerfumeReviewController extends GetxController {
  final nameController = TextEditingController();
  final brandController = TextEditingController();
  final commentController = TextEditingController();

  var reviewerId = ''.obs;
  var reviewerUsername = ''.obs;
  var selectedGenre = "Unisex".obs;
  var selectedSeason = "Spring".obs;
  var selectedOccasion = "Day".obs;
  var selectedLongevity = "Moderate".obs;
  var selectedSillage = "Moderate".obs;
  var overallRating = 3.0.obs;

  @override
  void onInit() {
    super.onInit();
    _getReviewerId();
  }

  Future<void> _getReviewerId() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        String email = currentUser.email!;
        var userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

        if (userSnapshot.docs.isNotEmpty) {
          reviewerId.value = currentUser.uid;
          reviewerUsername.value =
              userSnapshot.docs.first['username'] ?? 'Anonymous';
        } else {
          _showToast("User not found in Firestore.", Colors.red);
        }
      }
    } catch (e) {
      _showToast("Error fetching user: $e", Colors.red);
    }
  }

  Future<void> saveReview() async {
    if (nameController.text.isEmpty ||
        brandController.text.isEmpty ||
        reviewerId.isEmpty) {
      _showToast("Please fill in all fields and wait for the user to load.",
          Colors.red);
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('reviews').add({
        'name': nameController.text,
        'brand': brandController.text,
        'reviewerId': reviewerId.value,
        'reviewerUsername': reviewerUsername.value,
        'genre': selectedGenre.value,
        'season': selectedSeason.value,
        'occasion': selectedOccasion.value,
        'longevity': selectedLongevity.value,
        'sillage': selectedSillage.value,
        'overallRating': overallRating.value.toInt(),
        'reviewDate': FieldValue.serverTimestamp(),
        'comment':
            commentController.text.isEmpty ? null : commentController.text,
      });

      _showToast("Review successfully created!", Colors.green);
      Get.offAllNamed('/home');
    } catch (e) {
      _showToast("Error saving review: $e", Colors.red);
    }
  }

  void _showToast(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
