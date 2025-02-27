import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxString uid = "".obs;
  RxString username = "".obs;
  RxBool isLoading = false.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<double> weeklyIncome = List.filled(7, 0.0).obs;
  RxList<double> weeklyOutcome = List.filled(7, 0.0).obs;
  RxDouble total = 0.0.obs;
  
  @override
  void onInit() {
    fetchUserData();
    super.onInit();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      uid.value = prefs.getString('UID')!;
      DocumentSnapshot data = await _firestore
          .collection('users')
          .doc(uid.value)
          .collection('data')
          .doc('username') // Dokumen yang menyimpan field "username"
          .get();
      username.value = data.get('username');
      await fetchGraphData();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> fetchGraphData() async {
    List<String> day = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];
    try {
      isLoading.value = true;
      for (var i = 0; i < 7; i++) {
        total.value = 0.0;
        QuerySnapshot data = await _firestore
            .collection('users')
            .doc(uid.value)
            .collection('transactions')
            .where('day', isEqualTo: day[i])
            .where('type', isEqualTo: "In")
            .get();
        for (var documents in data.docs) {
          total.value = total.value + documents['amount'];
        }
        weeklyIncome[i] = total.value;
        total.value = 0.0;
        data = await _firestore
            .collection('users')
            .doc(uid.value)
            .collection('transactions')
            .where('day', isEqualTo: day[i])
            .where('type', isEqualTo: "Out")
            .get();
        for (var documents in data.docs) {
          total.value = total.value + documents['amount'];
        }
        weeklyOutcome[i] = total.value;
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }
}
