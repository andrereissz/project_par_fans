import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/telas/home.dart';
import 'package:project_par_fans/telas/login.dart';
import 'package:project_par_fans/telas/review.dart';
import 'package:project_par_fans/telas/singup.dart';
import 'package:project_par_fans/telas/userProfile.dart';
import 'package:project_par_fans/theme.dart';
import 'firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Login()),
        GetPage(
            name: '/create-review', page: () => CreatePerfumeReviewScreen()),
        GetPage(
            name: '/home',
            page: () => Home(),
            transition: Transition.noTransition),
        GetPage(
            name: '/user',
            page: () => Userprofile(),
            transition: Transition.noTransition),
        GetPage(
            name: '/singup', page: () => Singup(), transition: Transition.fade)
      ],
      home: Login(),
      theme: AppTheme.theme,
    ),
  );
}
