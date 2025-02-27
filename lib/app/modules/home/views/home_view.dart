import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tugas_besar_motion/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:tugas_besar_motion/app/widgets/custom_chart.dart';
import 'package:tugas_besar_motion/app/widgets/custom_list_tile.dart';
import 'package:tugas_besar_motion/app/modules/login/controllers/login_controller.dart';
import 'package:tugas_besar_motion/app/modules/transaction/controllers/transaction_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final transactionController = Get.put(TransactionController());
    final dashboardController = Get.put(DashboardController());
    return Obx(() => controller.isLoading.value
        ? Material(
            color: Get.theme.scaffoldBackgroundColor,
            child: const Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome Back, ",
                                style:
                                    Theme.of(context).textTheme.headlineMedium!,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${controller.username.value}!",
                                style:
                                    Theme.of(context).textTheme.displaySmall!,
                              )
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width / 7,
                          ),
                          IconButton(
                            onPressed: () => Get.toNamed('profile'),
                            icon: Icon(Icons.settings),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [const Color(0xFF00623B), Colors.green]),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Balance",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(height: 5),
                            Text(
                                "\Rp.${transactionController.formattedBalance.value}",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: Colors.white)),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Card(
                        elevation: 2,
                        color: Get.theme.cardColor,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            CustomChart(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recent Transactions",
                            style: Theme.of(context).textTheme.displaySmall!,
                          ),
                          TextButton(
                            onPressed: () =>
                                dashboardController.onItemTapped(1),
                            child: Text(
                              "See All",
                            ),
                          ),
                        ],
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
                              .limit(4)
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

                            return Column(children: [
                              for (final document in snapshot.data!.docs)
                                Customlistbuilder(
                                  description: document.data()['description'],
                                  amount: document.data()['amount'],
                                  type: document.data()['type'],
                                  docId: document.id,
                                  timestamp: document.data()['timestamp'],
                                ),
                            ]);
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ));
  }
}
