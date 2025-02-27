import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tugas_besar_motion/app/modules/transaction/controllers/transaction_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController =
        Get.put(TransactionController());
    return Obx(() => Scaffold(
          body: PageView(
            controller: controller.pageController,
            onPageChanged: (index) => controller.selectedIndex.value = index,
            children: controller.pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.onItemTapped,
            selectedItemColor: Color(0xFF00623B),
            unselectedItemColor: const Color.fromARGB(255, 130, 130, 130),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SizedBox.shrink(), // Kosongkan karena FAB ada di tengah
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on_outlined),
                activeIcon: Icon(Icons.monetization_on),
                label: 'Transaction',
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (controller.isFabExpanded.value) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: "income",
                      backgroundColor: Colors.green,
                      mini: false,
                      onPressed: () {
                        transactionController.addTransactionInputDialog("In");
                        controller.toggleFab();
                      },
                      child: const Icon(Icons.arrow_upward),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                    ),
                    FloatingActionButton(
                      heroTag: "outcome",
                      backgroundColor: Colors.red,
                      mini: false,
                      onPressed: () {
                        transactionController.addTransactionInputDialog("Out");
                        controller.toggleFab();
                      },
                      child: const Icon(Icons.arrow_downward),
                    ),
                  ],
                ),
              ],
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  FloatingActionButton(
                    heroTag: "mainFab",
                    backgroundColor: controller.isFabExpanded.value
                        ? Color(0xFF00623B)
                        : Get.theme.scaffoldBackgroundColor,
                    onPressed: controller.toggleFab,
                    child: Icon(
                      controller.isFabExpanded.value ? Icons.close : Icons.add,
                      color: controller.isFabExpanded.value
                          ? Get.theme.scaffoldBackgroundColor
                          : Color(0xFF00623B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Add Transaction",
                    style: TextStyle(
                        fontSize: 12,
                        color: controller.isFabExpanded.value
                            ? Color(0xFF00623B)
                            : Color.fromARGB(255, 130, 130, 130)),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
