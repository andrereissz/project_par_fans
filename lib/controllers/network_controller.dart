import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/model/perfumeReview.dart';

class NetworkController extends GetxController {
  var reviews = <PerfumeReview>[].obs;
  var isLoading = false.obs;
  var hasMoreReviews = true.obs;

  int _currentOffset = 0;
  static const int _pageSize = 10;
  final List<String> _allFollowingIds = [];

  @override
  void onInit() {
    super.onInit();
    _fetchFollowing();
  }

  Future<void> _fetchFollowing() async {
    try {
      isLoading.value = true;
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      final followingSnapshot = await FirebaseFirestore.instance
          .collection('network')
          .where('uidUser', isEqualTo: currentUserId)
          .get();

      _allFollowingIds.addAll(
        followingSnapshot.docs.map((doc) => doc['uidFollows'] as String),
      );

      if (_allFollowingIds.isEmpty) {
        showToast("You're not following anyone yet.", Colors.red);
        hasMoreReviews.value = false;
        isLoading.value = false;
        return;
      }

      // Carrega os primeiros reviews
      await fetchReviews();
    } catch (e) {
      showToast('Error fetching following: $e', Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchReviews() async {
    try {
      isLoading.value = true;

      final pagedIds =
          _allFollowingIds.skip(_currentOffset).take(_pageSize).toList();

      if (pagedIds.isEmpty) {
        hasMoreReviews.value = false;
        return;
      }

      final reviewsSnapshot = await FirebaseFirestore.instance
          .collection('reviews')
          .where('reviewerId', whereIn: pagedIds)
          .get();

      if (reviewsSnapshot.docs.isEmpty && _currentOffset == 0) {
        showToast("No reviews available from your network.", Colors.red);
        hasMoreReviews.value = false;
        reviews.clear();
        return;
      }

      reviews.addAll(
        reviewsSnapshot.docs
            .map((doc) => PerfumeReview.fromMap(doc.data()))
            .toList(),
      );

      reviews.sort((b, a) => a.reviewDate.compareTo(b.reviewDate));

      _currentOffset += _pageSize;

      if (_currentOffset >= _allFollowingIds.length) {
        hasMoreReviews.value = false;
      }
    } catch (e) {
      showToast('Error fetching reviews: $e', Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshReviews() async {
    isLoading.value = true;
    _currentOffset = 0;
    reviews.clear();
    hasMoreReviews.value = true;
    await fetchReviews();
    isLoading.value = false;
  }
}

void showToast(String message, Color color) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 14.0,
  );
}
