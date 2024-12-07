import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Bottomnav {
  static Widget getBarraNav(int currIndex) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: currIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: (int newIndex) {
        switch (newIndex) {
          case (0):
            Get.offAndToNamed('/home');
            break;
          case (1):
            Get.offAndToNamed('/network');
            break;
          case (2):
            Get.offAndToNamed('/user',
                arguments: FirebaseAuth.instance.currentUser?.uid);
            break;
          case (3):
            Get.offAndToNamed('/config');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
            label: "Reviews", icon: Icon(Icons.air_outlined)),
        BottomNavigationBarItem(label: "Network", icon: Icon(Icons.people)),
        BottomNavigationBarItem(label: "User", icon: Icon(Icons.person)),
        BottomNavigationBarItem(label: "Settings", icon: Icon(Icons.settings)),
      ],
    );
  }
}
