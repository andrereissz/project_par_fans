import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/loginController.dart';

class Login extends GetView<Logincontroller> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(
      data: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.black)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Image.asset('assets/logo.png', fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                  return Text('Image not found');
                }),
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
              SizedBox(
                width: 200,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Login",
                    )),
              ),
              SizedBox(
                width: 200,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Register",
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
