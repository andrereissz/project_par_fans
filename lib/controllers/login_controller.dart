import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    if (FirebaseAuth.instance.currentUser != null) {
      Get.offNamed('/home');
    }
  }

  Future<void> singIn({required String email, required String password}) async {
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
          gravity: ToastGravity.TOP);
    }
  }
}
