import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/bottomNav.dart';
import 'package:project_par_fans/controllers/auth_controller.dart';

class SettingsView extends GetView<AuthController> {
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bottomnav.getBarraNav(3),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Account Settings",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  _showSignOutDialog(context);
                },
                child: Center(
                  child: Text(
                    "Sign Out",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text(
          "Are you sure?",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey),
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    Get.back();
                    await controller.signOut();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                  ),
                  child: Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
