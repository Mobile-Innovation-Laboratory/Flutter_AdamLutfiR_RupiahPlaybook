import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tugas_besar_motion/app/modules/home/controllers/home_controller.dart';
import 'package:tugas_besar_motion/app/modules/login/controllers/login_controller.dart';
import 'package:tugas_besar_motion/app/widgets/custom_button.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    Get.put(ProfileController());
    final HomeController homeController = Get.put(HomeController());
    return Obx(() => controller.isLoading.value
        ? Material(
            color: Get.theme.scaffoldBackgroundColor,
            child: const Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Settings',
                style: Theme.of(context).textTheme.bodyLarge!,
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Get.theme.cardColor,
                          child: Center(
                            child: Text(
                              controller.username.value[0],
                              style: Theme.of(context).textTheme.displayLarge!,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: controller.changeUsernameDialog,
                          child: Card(
                            color: Get.theme.cardColor,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Row(
                                children: [
                                  Icon(Icons.email,
                                      color: Colors.green, size: 28),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Username",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!,
                                      ),
                                      Text(
                                        controller.username.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: controller.changeEmailDialog,
                          child: Card(
                            color: Get.theme.cardColor,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Row(
                                children: [
                                  Icon(Icons.email,
                                      color: Colors.green, size: 28),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Email",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!,
                                      ),
                                      Text(
                                        controller.userEmail.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomButton(
                            text: "Logout",
                            onTap: () => loginController.logout(),
                            height: 16,
                            width: 16)
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
