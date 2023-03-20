import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/widgets/wrapper.dart';

import '../widgets/fab.dart';
import 'new_transaction.dart';
import 'trans_controller.dart';
import 'trans_model.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      child: Scaffold(
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
      ),
    );
  }
}
