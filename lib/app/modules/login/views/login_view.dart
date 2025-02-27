import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:tugas_besar_motion/app/widgets/custom_button.dart';
import 'package:tugas_besar_motion/app/widgets/custom_text_field.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Obx(() => controller.isLoading.value
        ? Material(
            color: Get.theme.scaffoldBackgroundColor,
            child: const Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundImage:
                              AssetImage('assets/splash/Splash.png'),
                          backgroundColor: Get.theme.scaffoldBackgroundColor,
                        ),
                        Text(
                          'Welcome to Rupiah Playbook!',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'Save your money from unnecessary expenses',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: const Color(0xFF707070),
                                  ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                            hintText: 'Email',
                            icon: const Icon(
                              Icons.email_outlined,
                              color: Color(0xFF344E41),
                            ),
                            // textInputType: TextInputType.emailAddress,
                            controller: controller.emailController),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: 'Password',
                          icon: const Icon(
                            Icons.lock_outline,
                            color: Color(0xFF344E41),
                          ),
                          // textInputType: TextInputType.visiblePassword,
                          controller: controller.passwordController,
                          isPassword: true,
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          text: "Login",
                          onTap: () => controller.login(
                              controller.emailController.text,
                              controller.passwordController.text),
                          height: 16,
                          width: 16,
                        ),
                        TextButton(
                          onPressed: () => Get.offNamed('/register'),
                          child: Text("Don't have an account? Sign up"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
  }
}
