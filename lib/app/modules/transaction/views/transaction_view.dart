import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(TransactionController());
    return Obx(() => controller.isLoading.value
        ? const Material(
            child: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: AppBar(title: Text("Transaction")),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                      controller: controller.descriptionController,
                      decoration: InputDecoration(labelText: "Description")),
                  SizedBox(height: 20),
                  TextField(
                      controller: controller.amountController,
                      decoration: InputDecoration(labelText: "Amount")),
                  SizedBox(height: 20),
                  TextField(
                      controller: controller.typeController,
                      decoration: InputDecoration(labelText: "Type")),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      controller.addTransaction(
                          controller.descriptionController.text,
                          int.parse(controller.amountController.text),
                          controller.typeController.text);
                    },
                    child: Text("Add"),
                  ),
                ],
              ),
            ),
          ));
  }
}
