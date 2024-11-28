import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/services/authentication.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

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
                  controller: emailController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.mail),
                      border: OutlineInputBorder(),
                      labelText: 'Email'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: passwordController,
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
                    onPressed: () async {
                      await Authentication().singIn(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    },
                    child: Text(
                      "Login",
                    )),
              ),
              SizedBox(
                width: 200,
                child: TextButton(
                    onPressed: () {
                      Get.toNamed(
                        '/singup',
                      );
                    },
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
