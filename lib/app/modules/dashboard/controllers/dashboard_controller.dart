import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tugas_besar_motion/app/modules/home/views/home_view.dart';
import 'package:tugas_besar_motion/app/modules/profile/views/profile_view.dart';
import 'package:tugas_besar_motion/app/modules/transaction/views/transaction_view.dart';

class DashboardController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final List<Widget> pages = [
    const HomeView(),
    const TransactionView(),
    const ProfileView(),
  ];

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
