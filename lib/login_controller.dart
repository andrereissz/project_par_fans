import 'package:firebase_auth/firebase_auth.dart';
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
}
