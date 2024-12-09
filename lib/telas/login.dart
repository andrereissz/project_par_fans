import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/controllers/login_controller.dart';
import 'package:project_par_fans/services/auth_service.dart';

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    var isPasswordVisible = false.obs;

    return Scaffold(
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
              child: Obx(
                () => TextFormField(
                  controller: passwordController,
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
                  await controller.singIn(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
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
    );
  }
}
