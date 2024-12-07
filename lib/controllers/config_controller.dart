import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ConfigController extends GetxController {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/login');
  }
}
