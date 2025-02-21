import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> addTransaction(
      String description, int amount, String type) async {
    String uid = _auth.currentUser!.uid;
    if (uid.isEmpty) return;
    try {
      isLoading.value = true;
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .doc(DateTime.timestamp().toString())
          .set({
        'description': description,
        'amount': amount,
        'timestamp': DateTime.timestamp(),
        'type': type
      });
      Get.snackbar("Success", "Transaction successfully saved");
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
