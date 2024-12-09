import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/model/user.dart';
import 'package:project_par_fans/model/perfumeReview.dart';

class UserProfileController extends GetxController {
  var user = Rx<UserModel?>(null);
  var isFollowing = false.obs;
  var isOwnProfile = false.obs; // Para verificar se está no próprio perfil
  var reviews = <PerfumeReview>[].obs;
  var displayedReviews = <PerfumeReview>[].obs;
  var isLoading = true.obs;
  var followerCount = 0.obs;
  var followingCount = 0.obs;
  var hasMoreReviews = true.obs;

  final int reviewsPerPage = 4;
  final currentUser = FirebaseAuth.instance.currentUser;
  final networkRef = FirebaseFirestore.instance.collection('network');

  late String reviewerId;

  @override
  void onInit() {
    super.onInit();

    // Recebe o reviewerId passado como argumento
    reviewerId = Get.arguments;

    final currentUser = FirebaseAuth.instance.currentUser;

    if (reviewerId == currentUser?.uid) {
      isOwnProfile.value = true;
    } else {
      isOwnProfile.value = false;
      _checkIfFollowing();
    }

    _fetchUserProfile();
    _fetchUserReviews();

    // Contagem de seguidores e seguidos
    _fetchFollowerCount();
    _fetchFollowingCount();
  }

  void _fetchUserProfile() async {
    try {
      final reviewerSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: reviewerId)
          .get();
      if (reviewerSnapshot.docs.isNotEmpty) {
        final userDoc = reviewerSnapshot.docs.first;
        user.value = UserModel.fromJson(userDoc.data()!);
      } else {
        showToast('User profile not found', Colors.red);
      }
    } catch (e) {
      showToast('Error fetching user profile: $e', Colors.red);
    }
  }

  void _fetchFollowerCount() async {
    try {
      // Contar quantos usuários estão seguindo o usuário atual
      final followerQuery =
          await networkRef.where('uidFollows', isEqualTo: reviewerId).get();

      followerCount.value = followerQuery.docs.length;
    } catch (e) {
      showToast('Error fetching follower count: $e', Colors.red);
    }
  }

  void _fetchFollowingCount() async {
    try {
      // Contar quantos usuários o usuário está seguindo
      final followingQuery =
          await networkRef.where('uidUser', isEqualTo: reviewerId).get();

      followingCount.value = followingQuery.docs.length;
    } catch (e) {
      showToast('Error fetching following count: $e', Colors.red);
    }
  }

  void refreshUserProfile() async {
    try {
      isLoading.value = true;
      await Future.wait([
        _fetchUserProfile(),
        _fetchUserReviews(),
        _fetchFollowerCount(),
        _fetchFollowingCount(),
      ] as Iterable<Future>);
    } finally {
      isLoading.value = false;
    }
  }

  void _checkIfFollowing() async {
    try {

      final query = await networkRef
          .where('uidUser', isEqualTo: currentUser?.uid)
          .where('uidFollows', isEqualTo: reviewerId)
          .get();

      isFollowing.value = query.docs.isNotEmpty;
    } catch (e) {
      showToast('Error checking follow status: $e', Colors.red);
    }
  }

  void followUser() async {
    try {
      await networkRef.add({
        'uidUser': currentUser?.uid,
        'uidFollows': reviewerId,
      });

      isFollowing.value = true;
      showToast('You are now following this user', Colors.blue);
      _fetchFollowingCount();
      refreshUserProfile();
    } catch (e) {
      showToast('Error following user: $e', Colors.red);
    }
  }

  void unfollowUser() async {
    try {
      final query = await networkRef
          .where('uidUser', isEqualTo: currentUser?.uid)
          .where('uidFollows', isEqualTo: reviewerId)
          .get();

      if (query.docs.isNotEmpty) {
        await query.docs.first.reference.delete();
        isFollowing.value = false;
        showToast('You have unfollowed this user', Colors.blue);
        _fetchFollowingCount();
        refreshUserProfile();
      }
    } catch (e) {
      showToast('Error unfollowing user: $e', Colors.red);
    }
  }

  void _fetchUserReviews() async {
    try {
      isLoading.value = true;
      final snapshot = await FirebaseFirestore.instance
          .collection('reviews')
          .where('reviewerId', isEqualTo: reviewerId)
          .get();

      reviews.value = snapshot.docs
          .map((doc) => PerfumeReview.fromMap(doc.data()))
          .toList();

      // Exibe os primeiros reviews
      displayedReviews.value = reviews.take(reviewsPerPage).toList();
      hasMoreReviews.value = reviews.length > displayedReviews.length;
    } catch (e) {
      showToast('Error fetching reviews: $e', Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  void loadMoreReviews() {
    try {
      final nextReviews =
          reviews.skip(displayedReviews.length).take(reviewsPerPage).toList();
      displayedReviews.addAll(nextReviews);
    } catch (e) {
      showToast('Error loading more reviews: $e', Colors.red);
    }
  }

  void deleteReview(PerfumeReview review) async {
    try {
      final query = await FirebaseFirestore.instance
          .collection('reviews')
          .where('name', isEqualTo: review.name)
          .where('brand', isEqualTo: review.brand)
          .where('reviewerId',
              isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .where('reviewDate', isEqualTo: review.reviewDate)
          .get();

      if (query.docs.isNotEmpty) {
        await query.docs.first.reference.delete();
        showToast('Review deleted', Colors.green);
      }
    } catch (e) {
      showToast('Error deleting the review: $e', Colors.red);
    }
  }

  void showToast(String message, Color color) {
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
