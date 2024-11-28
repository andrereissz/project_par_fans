import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/splash_controller.dart';

class Splash extends GetView<SplashController> {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final controller = Get.put(SplashController());

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            height: 200,
            child: Image.asset('assets/logo.png', fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
              return Text('Image not found');
            }),
          ),
        ));
  }
}
