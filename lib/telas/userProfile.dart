import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/bottomNav.dart';

class UserProfile extends GetView {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.black)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(),
        bottomNavigationBar: Bottomnav.getBarraNav(1),
      ),
    );
  }
}
