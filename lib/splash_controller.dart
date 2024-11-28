import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print('splashou');
    if (FirebaseAuth.instance.currentUser != null) {
      Future.delayed(Duration(seconds: 1), () {
        Get.offNamed('/home');
      });
    } else {
      Future.delayed(Duration(seconds: 1), () {
        Get.offNamed('/login');
      });
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
