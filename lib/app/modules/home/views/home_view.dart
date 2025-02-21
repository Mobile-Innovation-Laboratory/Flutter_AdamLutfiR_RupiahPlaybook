import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tugas_besar_motion/app/modules/login/controllers/login_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final loginController = Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        // title: Text(controller.uid!),
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Center(child: Text("Hai")),
    );
  }
}
