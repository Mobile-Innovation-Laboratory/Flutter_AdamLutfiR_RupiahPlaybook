import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tugas_besar_motion/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

// class CustomChart extends StatelessWidget {
//   List<double> incomeData = [];
//   List<double> outcomeData = [];
//   CustomChart({super.key, required this.incomeData, required this.outcomeData});

//   @override
//   Widget build(BuildContext context) {
//     print(incomeData);
//     print(outcomeData);
//     final titleData = [
//       "Mon",
//       "Tue",
//       "Wed",
//       "Thu",
//       "Fri",
//       "Sat",
//       "Sun",
//     ];

//     final incomeFlSpot = [
//       FlSpot(0, incomeData[0]),
//       FlSpot(1, incomeData[1]),
//       FlSpot(2, incomeData[2]),
//       FlSpot(3, incomeData[3]),
//       FlSpot(4, incomeData[4]),
//       FlSpot(5, incomeData[5]),
//       FlSpot(6, incomeData[6]),
//     ];

//     final outcomeFlSpot = [
//       FlSpot(0, outcomeData[0]),
//       FlSpot(1, outcomeData[1]),
//       FlSpot(2, outcomeData[2]),
//       FlSpot(3, outcomeData[3]),
//       FlSpot(4, outcomeData[4]),
//       FlSpot(5, outcomeData[5]),
//       FlSpot(6, outcomeData[6]),
//     ];

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SizedBox(
//         height: 300,
//         child: LineChart(
//           LineChartData(
//             gridData: FlGridData(show: false),
//             titlesData: FlTitlesData(
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false, reservedSize: 40),
//               ),
//               rightTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false, reservedSize: 40),
//               ),
//               topTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false, reservedSize: 40),
//               ),
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   interval: 1,
//                   getTitlesWidget: (value, meta) {
//                     int index = value.toInt();
//                     if (index >= 0 && index < titleData.length) {
//                       return Text(titleData[index]);
//                     }
//                     return Text("");
//                   },
//                 ),
//               ),
//             ),
//             borderData: FlBorderData(show: false),
//             lineBarsData: [
//               LineChartBarData(
//                 preventCurveOverShooting: true,
//                 curveSmoothness: 0.15,
//                 spots: incomeFlSpot,
//                 isCurved: true,
//                 color: Colors.lightBlueAccent,
//                 barWidth: 3,
//                 dotData: FlDotData(show: false),
//               ),
//               LineChartBarData(
//                 preventCurveOverShooting: true,
//                 curveSmoothness: 0.15,
//                 spots: outcomeFlSpot,
//                 isCurved: true,
//                 color: Colors.redAccent,
//                 barWidth: 3,
//                 dotData: FlDotData(show: false),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomChart extends StatelessWidget {
  CustomChart({super.key});
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final titleData = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: BarChart(
        BarChartData(
          barGroups: List.generate(7, (index) {
            return BarChartGroupData(
              x: index,
              barsSpace: 4,
              barRods: [
                BarChartRodData(
                  toY: controller.weeklyIncome[index],
                  // gradient: LinearGradient(colors: [
                  //   Colors.blueAccent,
                  //   Colors.blue,
                  //   Colors.green,
                  //   Colors.greenAccent
                  // ]),
                  color: const Color(0xFF00623B),
                  width: 10,
                  borderRadius: BorderRadius.circular(4),
                ),
                BarChartRodData(
                  toY: controller.weeklyOutcome[index],
                  // gradient: LinearGradient(colors: [
                  //   Colors.redAccent,
                  //   Colors.red,
                  //   Colors.orange,
                  //   Colors.orangeAccent
                  // ]),
                  color: Colors.red,
                  width: 10,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < titleData.length) {
                    return Text(titleData[index]);
                  }
                  return Text("");
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false, reservedSize: 40),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => Get.theme.scaffoldBackgroundColor,
            ),
          ),
        ),
        curve: Curves.easeOut,
        duration: Durations.extralong1,
      ),
    );
  }
}
