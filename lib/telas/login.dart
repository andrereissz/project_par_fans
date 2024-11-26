import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/loginController.dart';

class Login extends GetView<Logincontroller> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Image.asset('assets/logo.png', fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                return Text('Image not found');
              }),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.mail),
                    border: OutlineInputBorder(),
                    labelText: 'Username'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.key),
                    border: OutlineInputBorder(),
                    labelText: 'Password'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
