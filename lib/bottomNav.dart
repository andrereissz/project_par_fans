import 'package:firebase_auth/firebase_auth.dart';
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
          case (2):
            Get.offAndToNamed('/user',
                arguments: FirebaseAuth.instance.currentUser?.uid);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
            label: "Reviews", icon: Icon(Icons.air_outlined)),
        BottomNavigationBarItem(label: "Network", icon: Icon(Icons.people)),
        BottomNavigationBarItem(label: "User", icon: Icon(Icons.person))
      ],
    );
  }
}
