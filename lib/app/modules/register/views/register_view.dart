import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tugas_besar_motion/app/widgets/custom_button.dart';
import 'package:tugas_besar_motion/app/widgets/custom_text_field.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(RegisterController());
    return Obx(() => controller.isLoading.value
        ? const Material(
            child: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage('assets/splash/Splash.png'),
                        backgroundColor: Get.theme.scaffoldBackgroundColor,
                      ),
                      Text(
                        'Welcome to Rupiah Playbook!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Save your money from unnecessary expenses',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: const Color(0xFF707070),
                            ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                          hintText: 'Username',
                          icon: const Icon(
                            Icons.email_outlined,
                            color: Color(0xFF344E41),
                          ),
                          textInputType: TextInputType.name,
                          controller: controller.usernameController),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                          hintText: 'Email',
                          icon: const Icon(
                            Icons.email_outlined,
                            color: Color(0xFF344E41),
                          ),
                          textInputType: TextInputType.emailAddress,
                          controller: controller.emailController),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        hintText: 'Password',
                        icon: const Icon(
                          Icons.email_outlined,
                          color: Color(0xFF344E41),
                        ),
                        textInputType: TextInputType.emailAddress,
                        controller: controller.passwordController,
                        isPassword: true,
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        text: "Register",
                        onTap: () => controller.register(
                            controller.emailController.text,
                            controller.passwordController.text,
                            controller.usernameController.text),
                        height: 16,
                        width: 16,
                      ),
                      TextButton(
                        onPressed: () => Get.offNamed('/login'),
                        child: Text("Already have an account? Login"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
  }
}
