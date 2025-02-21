import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxString uid = "".obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    useruid();
  }

  Future<void> useruid() async {
    try {
      isLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      uid.value = await prefs.getString('UID')!;
    } finally {
      isLoading.value = false;
    }
  }
}
