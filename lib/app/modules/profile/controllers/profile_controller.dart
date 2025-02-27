import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_besar_motion/app/widgets/custom_button.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  var isValid = false.obs;
  RxString userEmail = "".obs;
  RxString username = "".obs;
  RxString uid = "".obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }

  Future<void> getUserData() async {
    try {
      isLoading.value = true;
      userEmail.value = await _auth.currentUser!.email!;
      await fetchUsername();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> fetchUsername() async {
    try {
      isLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      uid.value = prefs.getString('UID')!;
      DocumentSnapshot data = await _firestore
          .collection('users')
          .doc(uid.value)
          .collection('data')
          .doc('username')
          .get();
      username.value = data.get('username');
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> updateEmail(String newEmail) async {
    try {
      if (newEmail.isEmpty) {
        Get.snackbar("Error", "Please enter your new email");
        return;
      }

      isLoading.value = true;
      User? user = _auth.currentUser;

      if (user != null) {
        await user.verifyBeforeUpdateEmail(newEmail);
        Get.snackbar("Success",
            "A verification email has been sent to $newEmail. Please confirm to complete the update.");
      } else {
        Get.snackbar("Error", "User not logged in.");
      }
      await fetchUsername();
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'email-already-in-use') {
        Get.snackbar(
            "Error", "Email already in use. Please use another email.");
      } else if (e.code == 'invalid-email') {
        Get.snackbar("Error", "Invalid email format. Please check your email.");
      } else if (e.code == 'requires-recent-login') {
        Get.snackbar("Error", "Please re-authenticate before changing email.");
      } else {
        Get.snackbar("Error", "An error occurred, Please try again.");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> updateUsername(String newUsername) async {
    try {
      isLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      uid.value = (await prefs.getString('UID'))!;
      await _firestore
          .collection('users')
          .doc(uid.value)
          .collection('data')
          .doc('username')
          .update({'username': newUsername});
      await fetchUsername();
      Get.back();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  void changeEmailDialog() {
    Get.defaultDialog(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: "Change Email",
        content: Column(
          children: [
            TextField(
              style: Get.textTheme.bodyMedium!,
              controller: emailController,
              decoration: InputDecoration(
                labelText: "New Email",
              ),
              onChanged: (value) => isValid.value = emailController.text != "",
            ),
          ],
        ),
        cancel: CustomButton(
            text: "Cancel",
            onTap: () {
              Get.back();
              emailController.clear();
            },
            height: 2,
            width: 1),
        confirm: CustomButton(
            text: "Submit",
            onTap: () {
              if (isValid.value) {
                updateEmail(emailController.text);
              } else {
                Get.snackbar(
                  "Error",
                  "Input tidak boleh kosong",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            height: 2,
            width: 1));
  }

  void changeUsernameDialog() {
    Get.defaultDialog(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: "Change Username",
        content: Column(
          children: [
            TextField(
              style: Get.textTheme.bodyMedium!,
              controller: usernameController,
              decoration: InputDecoration(labelText: "New Username"),
              onChanged: (value) =>
                  isValid.value = usernameController.text != "",
            ),
          ],
        ),
        cancel: CustomButton(
            text: "Cancel",
            onTap: () {
              Get.back();
              emailController.clear();
            },
            height: 2,
            width: 1),
        confirm: CustomButton(
            text: "Submit",
            onTap: () {
              if (isValid.value) {
                updateUsername(usernameController.text);
              } else {
                Get.snackbar(
                  "Error",
                  "Input tidak boleh kosong",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            height: 2,
            width: 1));
  }
}
