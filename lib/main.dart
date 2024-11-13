import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/telas/home.dart';
import 'package:project_par_fans/telas/login.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => Login()),
      GetPage(name: '/home', page: () => Home()),
    ],
    home: Login(),
  ));
}
