import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
      if (email == "") {
        Get.snackbar("Error", "Please enter your email");
      } else if (password == "") {
        Get.snackbar("Error", "Please enter your password");
      } else {
        isLoading.value = true;
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        userInit(email);
        Get.snackbar("Success",
            "Account created successfully, Please login with your registered account");
        isLoading.value = false;
        Get.offNamed('/login');
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'email-already-in-use') {
        Get.snackbar(
            "Error", "Email already in use. Please use another email.");
      } else if (e.code == 'invalid-email') {
        Get.snackbar("Error", "Invalid email format. Please check your email.");
      } else if (e.code == 'weak-password') {
        Get.snackbar(
            "Error", "Password is too weak. Please use a stronger password.");
      } else if (e.code == 'operation-not-allowed') {
        Get.snackbar("Error", "Email/password accounts are not enabled.");
      } else {
        Get.snackbar("Error", "An error occurred, Please try again.");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> userInit(String email) async {
    final db = FirebaseFirestore.instance;
    await db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('data')
        .doc('contact')
        .set({
      email: email,
    });
  }
}
