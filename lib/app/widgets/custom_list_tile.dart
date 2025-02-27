import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tugas_besar_motion/app/modules/transaction/controllers/transaction_controller.dart';

// class Customlistbuilder extends StatelessWidget {
//   final String description;
//   final int amount;
//   final String type;
//   final String docId;
//   Customlistbuilder({
//     super.key,
//     required this.description,
//     required this.amount,
//     required this.type,
//     required this.docId,
//   });
//   final TransactionController controller = Get.find<TransactionController>();
//   @override
//   Widget build(BuildContext context) {
//     bool isIncome = type == "In";
//     return ListTile(
//       leading: Icon(
//         isIncome ? Icons.arrow_upward : Icons.arrow_downward,
//         color: isIncome ? Colors.green : Colors.red,
//       ),
//       title: Text(
//         description,
//         style: Theme.of(context).textTheme.bodyMedium!,
//       ),
//       subtitle: Text(
//         amount.toString(),
//         style: Theme.of(context).textTheme.bodyMedium!,
//       ),
//       // trailing: Text(
//       //   isIncome ? "+$amount" : "-$amount",
//       //   style: TextStyle(
//       //     color: isIncome ? Colors.green : Colors.red,
//       //     fontWeight: FontWeight.bold,
//       //   ),
//       // ),
//       trailing: PopupMenuButton<String>(
//         color: Get.theme.scaffoldBackgroundColor,
//         onSelected: (value) {
//           if (value == "update") {
//             controller.updateTransactionInputDialog(
//                 docId, description, amount.toString(), type);
//           } else if (value == "delete") {
//             controller.deleteTransaction(docId, amount.toString(), type);
//           }
//         },
//         itemBuilder: (context) => [
//           PopupMenuItem(
//             value: "update",
//             child: Row(
//               children: [
//                 Icon(Icons.edit, color: Colors.blue),
//                 SizedBox(width: 8),
//                 Text("Update"),
//               ],
//             ),
//           ),
//           PopupMenuItem(
//             value: "delete",
//             child: Row(
//               children: [
//                 Icon(Icons.delete, color: Colors.red),
//                 SizedBox(width: 8),
//                 Text("Delete"),
//               ],
//             ),
//           ),
//         ],
//         icon: Icon(Icons.more_vert),
//       ),
//     );
//   }
// }

class Customlistbuilder extends StatelessWidget {
  final String description;
  final int amount;
  final String type;
  final String docId;
  final Timestamp timestamp; // Tambahkan timestamp

  Customlistbuilder({
    super.key,
    required this.description,
    required this.amount,
    required this.type,
    required this.docId,
    required this.timestamp, // Parameter timestamp
  });

  final TransactionController controller = Get.find<TransactionController>();

  // Fungsi untuk format timestamp menjadi "dd/MM/yyyy HH:mm"
  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd MMMM yyyy HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    bool isIncome = type == "In";

    return ListTile(
      // leading: Icon(
      //   isIncome ? Icons.arrow_upward : Icons.arrow_downward,
      //   color: isIncome ? Colors.green : Colors.red,
      // ),
      title: Text(
        description,
        style: Theme.of(context).textTheme.bodyMedium!,
      ),
      subtitle: Text(
        "Date : "
        "${formatTimestamp(timestamp)}",
        style: Theme.of(context).textTheme.bodySmall!,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isIncome
                ? "+ Rp. ${amount.toString()}"
                : "- Rp. ${amount.toString()}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isIncome ? Colors.green : Colors.red,
            ),
          ),
          PopupMenuButton<String>(
            color: Get.theme.scaffoldBackgroundColor,
            onSelected: (value) {
              if (value == "update") {
                controller.updateTransactionInputDialog(
                    docId, description, amount.toString(), type);
              } else if (value == "delete") {
                controller.deleteTransaction(docId, amount.toString(), type);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "update",
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      "Update",
                      style: Theme.of(context).textTheme.bodySmall!,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "delete",
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      "Delete",
                      style: Theme.of(context).textTheme.bodySmall!,
                    ),
                  ],
                ),
              ),
            ],
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
