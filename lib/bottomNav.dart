import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bottomnav {
  static Widget getBarraNav(int currIndex) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: currIndex,
      onTap: (int newIndex) {
        switch (newIndex) {
          case (0):
            Get.toNamed('/home');
            break;
          case (1):
            Get.toNamed('/user');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
            label: "Fragrances", icon: Icon(Icons.air_outlined)),
        BottomNavigationBarItem(label: "User", icon: Icon(Icons.person))
      ],
    );
  }
}
