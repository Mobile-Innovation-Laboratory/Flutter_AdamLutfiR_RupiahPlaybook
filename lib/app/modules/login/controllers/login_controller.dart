import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
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

  Future<void> login(String email, String password) async {
    try {
      if (email == "") {
        Get.snackbar("Error", "Please enter your email");
      } else if (password == "") {
        Get.snackbar("Error", "Please enter your password");
      } else {
        isLoading.value = true;
        UserCredential credential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        user.value = credential.user;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('UID', user.value!.uid);
        Get.snackbar("Success", "Login successful");
        Get.offNamed('/dashboard');
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'wrong-password') {
        Get.snackbar("Error", "Wrong password. Please try again.");
      } else if (e.code == 'user-not-found') {
        Get.snackbar("Error", "User not found. Please check your email.");
      } else {
        Get.snackbar("Error", "An error occurred. Please try again.");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    user.value = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.snackbar("Success", "You are now logged out");
    Get.offNamed('/login');
  }
}
