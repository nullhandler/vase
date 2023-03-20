import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/fab.dart';
import '../widgets/month_calender.dart';
import 'new_transaction.dart';
import 'trans_controller.dart';
import 'trans_model.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const MonthCalender(),
      ),
      body: GetBuilder<TransController>(
        builder: (TransController controller) {
          return Obx(() {
            return ListView.builder(
                itemCount: controller.transactions.length,
                itemBuilder: (context, pos) {
                  Transaction transaction = controller.transactions[pos];
                  return Text("${transaction.desc} ${transaction.amount}");
                });
          });
        },
      ),
      floatingActionButton: Fab(onTap: () {
        Get.to(const NewTransaction());
      }),
    );
  }
}
