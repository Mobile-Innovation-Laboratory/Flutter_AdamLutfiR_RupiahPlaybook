import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tugas_besar_motion/app/widgets/custom_button.dart';
import 'package:tugas_besar_motion/app/widgets/custom_list_tile.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(TransactionController());
    return Obx(() => controller.isLoading.value
        ? Material(
            color: Get.theme.scaffoldBackgroundColor,
            child: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            backgroundColor: Get.theme.scaffoldBackgroundColor,
            appBar: AppBar(
              title: Text(
                "Manage Your Activities",
                style: Theme.of(context).textTheme.bodyLarge!,
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Transaction Activities",
                        style: Theme.of(context).textTheme.headlineLarge!,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 150,
                                height: 150,
                                child: CircularProgressIndicator(
                                  value:
                                      controller.progressIndicatorValue.value /
                                          100,
                                  strokeWidth: 12,
                                  backgroundColor: Colors.red,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.green),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${controller.progressIndicatorValue.toStringAsFixed(0)}%",
                                style:
                                    Theme.of(context).textTheme.displayLarge!,
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "All Transactions",
                        style: Theme.of(context).textTheme.displaySmall!,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(controller.uid.value)
                              .collection('transactions')
                              .orderBy('timestamp', descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Center(
                                  child: Text("No transactions available"));
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final document = snapshot.data!.docs[index];
                                return Customlistbuilder(
                                  description: document.data()['description'],
                                  amount: document.data()['amount'],
                                  type: document.data()['type'],
                                  docId: document.id,
                                  timestamp: document.data()['timestamp'],
                                );
                              },
                            );

                            // return Column(children: [
                            //   for (final document in snapshot.data!.docs)
                            //     Customlistbuilder(
                            //       description: document.data()['description'],
                            //       amount: document.data()['amount'],
                            //       type: document.data()['type'],
                            //       docId: document.id,
                            //     ),
                            //   if (snapshot.data!.docs.length >=
                            //       controller.transactionLimit.value)
                            //     TextButton(
                            //       onPressed: () {
                            //         double currentPosition = scrollController
                            //             .position.pixels; // Simpan posisi scroll
                            //         controller.transactionLimit.value += 10;

                            //         // Tunggu perubahan UI, lalu scroll kembali ke posisi terakhir
                            //         Future.delayed(Duration(milliseconds: 200),
                            //             () {
                            //           scrollController.jumpTo(currentPosition);
                            //         });
                            //       },
                            //       child: const Text("Load More",
                            //           style: TextStyle(color: Colors.blue)),
                            //     ),
                            // ]);
                          },
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //     final currentPosition = controller.scrollController
                      //         .position.minScrollExtent; // Simpan posisi scroll
                      //     controller.transactionLimit.value += 10;

                      //     // Tunggu perubahan UI, lalu scroll kembali ke posisi terakhir
                      //     // WidgetsBinding.instance.addPostFrameCallback((_) {
                      //     controller.scrollController.jumpTo(currentPosition);
                      //     // });
                      //   },
                      //   child: const Text("Load More",
                      //       style: TextStyle(color: Colors.blue)),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ));
  }
}
