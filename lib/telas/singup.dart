import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_par_fans/services/authentication.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.black)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 50,
        ),
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
                  controller: usernameController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person),
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
                      await Authentication().singup(
                        email: emailController.text,
                        password: passwordController.text,
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
