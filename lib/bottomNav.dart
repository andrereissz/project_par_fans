import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bottomnav {
  static Widget getBarraNav(int currIndex) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: currIndex,
      onTap: (int newIndex) {
        switch (newIndex) {
          case (1):
            Get.toNamed('/home');
            break;
          case (2):
            Get.toNamed('/user');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
            label: "Reviews", icon: Icon(Icons.air_outlined)),
        BottomNavigationBarItem(label: "User", icon: Icon(Icons.person))
      ],
    );
  }
}
