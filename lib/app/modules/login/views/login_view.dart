import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? const Material(
            child: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: AppBar(title: Text("Login")),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                      controller: controller.emailController,
                      decoration: InputDecoration(labelText: "Email")),
                  TextField(
                      controller: controller.passwordController,
                      decoration: InputDecoration(labelText: "Password"),
                      obscureText: true),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => controller.login(
                        controller.emailController.text,
                        controller.passwordController.text),
                    child: Text("Login"),
                  ),
                  TextButton(
                    onPressed: () =>
                        Get.offNamed('/register'), // Navigasi ke RegisterView
                    child: Text("Don't have an account? Sign up"),
                  ),
                ],
              ),
            ),
          ));
  }
}
