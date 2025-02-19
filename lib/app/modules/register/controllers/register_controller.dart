import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var user = Rxn<User>();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  Future<void> register(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.snackbar("Success",
          "Account created successfully, Please login with your registered account");
      isLoading.value = false;
      Get.offNamed('/login');
    } catch (e) {
      Get.snackbar("Error", "The account email address already exists");
    }
  }
}
