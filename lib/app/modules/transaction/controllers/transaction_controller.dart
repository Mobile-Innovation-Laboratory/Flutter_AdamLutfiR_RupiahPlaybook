import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:tugas_besar_motion/app/modules/home/controllers/home_controller.dart';
import 'package:tugas_besar_motion/app/widgets/custom_button.dart';

class TransactionController extends GetxController {
  final HomeController Graphcontroller = Get.put(HomeController());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  RxString uid = "".obs;
  RxString formattedBalance = "".obs;
  RxString formattedIncome = "".obs;
  RxString formattedOutcome = "".obs;
  RxBool typeSwitch = false.obs;
  RxBool type = false.obs;
  RxBool isLoading = false.obs;
  RxBool isValid = false.obs;
  RxInt balance = 0.obs;
  RxMap<String, double> weeklyIncome = <String, double>{}.obs;
  RxMap<String, double> weeklyExpense = <String, double>{}.obs;
  RxDouble allIncome = 0.0.obs;
  RxDouble allOutcome = 0.0.obs;
  RxDouble progressIndicatorValue = 0.0.obs;
  RxDouble total = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBalance();
  }

  Future<void> fetchBalance() async {
    try {
      isLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      uid.value = (await prefs.getString('UID'))!;
      await fetchProgressData();
      DocumentSnapshot balanceSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid.value)
          .collection('data')
          .doc('balance')
          .get();
      Map<String, dynamic> data =
          balanceSnapshot.data() as Map<String, dynamic>;
      balance.value = data['balance'];
      formattedBalance.value =
          NumberFormat.decimalPattern().format(balance.value);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> setBalance(String type, int balance, int amount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    uid.value = (await prefs.getString('UID'))!;
    try {
      isLoading.value = true;
      if (type == "Out") {
        amount = -amount;
      }
      await _firestore
          .collection('users')
          .doc(uid.value)
          .collection('data')
          .doc('balance')
          .update({'balance': balance = balance + amount});
      await fetchBalance();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> fetchProgressData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    uid.value = (await prefs.getString('UID'))!;
    try {
      isLoading.value = true;
      allIncome.value = 0;
      allOutcome.value = 0;
      total.value = 0;
      QuerySnapshot data = await _firestore
          .collection('users')
          .doc(uid.value)
          .collection('transactions')
          .where('type', isEqualTo: "In")
          .get();
      for (var documents in data.docs) {
        allIncome.value = allIncome.value + documents['amount'];
      }
      data = await _firestore
          .collection('users')
          .doc(uid.value)
          .collection('transactions')
          .where('type', isEqualTo: "Out")
          .get();
      for (var documents in data.docs) {
        allOutcome.value = allOutcome.value + documents['amount'];
      }
      total.value = allIncome.value + allOutcome.value;
      total.value == 0
          ? progressIndicatorValue.value = 0
          : progressIndicatorValue.value =
              (allIncome.value) / total.value * 100;
      formattedIncome.value =
          NumberFormat.decimalPattern().format(allIncome.value);
      formattedOutcome.value =
          NumberFormat.decimalPattern().format(allOutcome.value);
      isLoading.value = false;
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      isLoading.value = false;
    }
  }

  void checkInput() {
    isValid.value = descriptionController.text.isNotEmpty &&
        amountController.text.isNotEmpty;
  }

  void addTransactionInputDialog(String type) {
    Get.defaultDialog(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: "$type Transaction",
        content: Column(
          children: [
            TextField(
              style: Get.textTheme.bodyMedium!,
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Description"),
              onChanged: (value) => checkInput(),
            ),
            SizedBox(height: 10),
            TextField(
              style: Get.textTheme.bodyMedium!,
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount"),
              onChanged: (value) => checkInput(),
            ),
          ],
        ),
        cancel: CustomButton(
            text: "Cancel",
            onTap: () {
              Get.back();
              descriptionController.clear();
              amountController.clear();
            },
            height: 2,
            width: 1),
        confirm: CustomButton(
            text: "Submit",
            onTap: () {
              if (isValid.value) {
                addTransaction(type, descriptionController.text,
                    int.parse(amountController.text));
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

  Future<void> addTransaction(
    String type,
    String description,
    int amount,
  ) async {
    try {
      isLoading.value = true;
      DateTime date = DateTime.now();
      await _firestore
          .collection('users')
          .doc(uid.value)
          .collection('transactions')
          .doc(DateTime.timestamp().toString())
          .set({
        'description': description,
        'amount': amount,
        'timestamp': DateTime.timestamp(),
        'type': type,
        'day': DateFormat('EEEE').format(date),
      });
      Get.back();
      await setBalance(type, balance.value, amount);
      await fetchProgressData();
      descriptionController.clear();
      amountController.clear();
      Graphcontroller.fetchGraphData();
    } catch (e) {
      Get.back();
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong");
      isLoading.value = false;
    }
  }

  void updateTransactionInputDialog(
      String docId, String description, String amount, String type) {
    descriptionController.text = description;
    amountController.text = amount;
    typeSwitch.value = false;
    bool isSame = false;
    Get.defaultDialog(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      title: "Update Transaction",
      content: Column(
        children: [
          TextField(
            style: Get.textTheme.bodyMedium!,
            controller: descriptionController,
            decoration: InputDecoration(labelText: "Description"),
            onChanged: (value) => checkInput(),
          ),
          SizedBox(height: 10),
          TextField(
            style: Get.textTheme.bodyMedium!,
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Amount"),
            onChanged: (value) => checkInput(),
          ),
          SizedBox(height: 10),
          CustomButton(
              text: "Change type",
              onTap: () {
                typeSwitch.value = true;
              },
              height: 2,
              width: 1)
        ],
      ),
      cancel: CustomButton(
          text: "Cancel",
          onTap: () {
            Get.back();
            descriptionController.clear();
            amountController.clear();
          },
          height: 2,
          width: 1),
      confirm: CustomButton(
          text: "Submit",
          onTap: () {
            if (isValid.value) {
              amountController.text == amount ? isSame = true : isSame = false;
              updateTransaction(type, docId, descriptionController.text,
                  int.parse(amountController.text), int.parse(amount), isSame);
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
          width: 1),
    );
  }

  Future<void> updateTransaction(String type, String docId,
      String newDescription, int newAmount, int oldAmount, bool isSame) async {
    try {
      isLoading.value = true;
      if (typeSwitch.value == true) {
        type == "In" ? type = "Out" : type = "In";
      }
      await _firestore
          .collection('users')
          .doc(uid.value)
          .collection('transactions')
          .doc(docId)
          .update({
        'description': newDescription,
        'amount': newAmount,
        "type": type
      });
      Get.back();
      isSame
          ? await setBalance(type, balance.value, 0)
          : setBalance(
              type,
              balance.value,
              newAmount >= oldAmount
                  ? newAmount = newAmount - oldAmount
                  : newAmount = oldAmount - newAmount);
      await fetchProgressData();
      descriptionController.clear();
      amountController.clear();
      Graphcontroller.fetchGraphData();
      Get.snackbar("Success", "Transaction updated");
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Failed to update transaction");
      Get.back();
    }
  }

  Future<void> deleteTransaction(
      String docId, String amount, String type) async {
    try {
      isLoading.value = true;
      await _firestore
          .collection('users')
          .doc(uid.value)
          .collection('transactions')
          .doc(docId)
          .delete();
      type == "In" ? type = "Out" : type = "In";
      await setBalance(type, balance.value, int.parse(amount));
      await Graphcontroller.fetchGraphData();
      await fetchProgressData();
      isLoading.value = false;
      Get.snackbar("Success", "Transaction deleted");
      Get.back();
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Failed to delete transaction");
      Get.back();
    }
  }
}
