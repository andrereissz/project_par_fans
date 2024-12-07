import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_par_fans/model/perfumeReview.dart';

class HomeController extends GetxController {
  var reviews = <PerfumeReview>[].obs;
  var displayedReviews = <PerfumeReview>[].obs;
  var isLoading = true.obs;
  var hasMoreReviews = true.obs;
  final int reviewsPerPage = 4;

  @override
  void onInit() {
    super.onInit();
    fetchReviews();
  }


  Future<void> refreshReviews() async {
    isLoading.value = true;
    fetchReviews();
    isLoading.value = false;
  }

  void fetchReviews() async {
    try {
      isLoading.value = true;
      final snapshot =
          await FirebaseFirestore.instance.collection('reviews').get();

      reviews.value = snapshot.docs
          .map((doc) => PerfumeReview.fromMap(doc.data()))
          .toList();

      // Carrega inicialmente os primeiros 4 reviews
      displayedReviews.value = reviews.take(reviewsPerPage).toList();
      hasMoreReviews.value = reviews.length > displayedReviews.length;
    } catch (e) {
      print('Error fetching reviews: $e');
      showToast("Failed to load reviews: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void loadMoreReviews() {
    final nextReviews =
        reviews.skip(displayedReviews.length).take(reviewsPerPage).toList();

    displayedReviews.addAll(nextReviews);
    hasMoreReviews.value = reviews.length > displayedReviews.length;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
