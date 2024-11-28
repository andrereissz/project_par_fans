import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/telas/home.dart';
import 'package:project_par_fans/telas/login.dart';
import 'package:project_par_fans/telas/singup.dart';
import 'package:project_par_fans/telas/splash.dart';
import 'firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(GetMaterialApp(
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => Splash()),
      GetPage(name: '/home', page: () => Home()),
      GetPage(name: '/login', page: () => Login()),
      GetPage(
          name: '/singup', page: () => Singup(), transition: Transition.fade)
    ],
    home: Splash(),
  ));
}
