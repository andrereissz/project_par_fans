import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreatePerfumeReviewController extends GetxController {
  final nameController = TextEditingController();
  final brandController = TextEditingController();

  var reviewerId = ''.obs;
  var reviewerUsername = ''.obs;
  var selectedCompartilhavel = "Unissex".obs;
  var selectedEstacao = "spring".obs;
  var selectedOcasiao = "day".obs;
  var notaGeral = 3.0.obs;

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
          reviewerId.value = userSnapshot.docs.first.id;
          reviewerUsername.value =
              userSnapshot.docs.first['username'] ?? 'Anônimo';
        } else {
          _showToast("Usuário não encontrado no Firestore.", Colors.red);
        }
      }
    } catch (e) {
      _showToast("Erro ao buscar usuário: $e", Colors.red);
    }
  }

  Future<void> saveReview() async {
    if (nameController.text.isEmpty ||
        brandController.text.isEmpty ||
        reviewerId.isEmpty) {
      _showToast(
          "Preencha todos os campos e aguarde o carregamento do usuário.",
          Colors.red);
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('reviews').add({
        'name': nameController.text,
        'brand': brandController.text,
        'reviewerId': reviewerId.value,
        'reviewerUsername': reviewerUsername.value,
        'notaCompartilhavel': selectedCompartilhavel.value,
        'notaEstacao': selectedEstacao.value,
        'notaOcasiao': selectedOcasiao.value,
        'notaGeral': notaGeral.value.toInt(),
      });

      _showToast("Review criado com sucesso!", Colors.green);
      Get.back();
    } catch (e) {
      _showToast("Erro ao salvar review: $e", Colors.red);
    }
  }

  void _showToast(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
