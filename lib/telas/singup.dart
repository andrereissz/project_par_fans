import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/controllers/sign_up_controller.dart';

class Singup extends GetView<SignUpController> {
  final controller = Get.put(SignUpController());

  var isPasswordVisible = false.obs;

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
                  controller: controller.usernameController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Username'),
                  focusNode: FocusNode(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: controller.emailController,
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
                child: Obx(
                  () => TextFormField(
                    controller: controller.passwordController,
                    obscureText: !isPasswordVisible.value,
                    decoration: InputDecoration(
                      icon: Icon(Icons.key),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          isPasswordVisible.value = !isPasswordVisible.value;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                child: TextButton(
                    onPressed: () async {
                      await controller.signUp(
                        username: controller.usernameController.text,
                        email: controller.emailController.text,
                        password: controller.passwordController.text,
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
