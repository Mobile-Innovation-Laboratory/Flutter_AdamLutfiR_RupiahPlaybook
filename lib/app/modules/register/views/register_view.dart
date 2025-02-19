import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? const Material(
            child: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: AppBar(title: Text("Register")),
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
                    onPressed: () => controller.register(
                        controller.emailController.text,
                        controller.passwordController.text),
                    child: Text("Register"),
                  ),
                  TextButton(
                    onPressed: () =>
                        Get.offNamed('/login'), // Kembali ke halaman login
                    child: Text("Already have an account? Login"),
                  ),
                ],
              ),
            ),
          ));
  }
}
