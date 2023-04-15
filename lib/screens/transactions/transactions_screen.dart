import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/screens/transactions/date_list_item.dart';
import 'package:vase/screens/transactions/monthly_stats_widget.dart';
import 'package:vase/widgets/wrapper.dart';

import '../widgets/fab.dart';
import '../widgets/month_calender.dart';
import 'new_transaction.dart';
import 'trans_controller.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      child: GetBuilder<TransController>(
        builder: (TransController controller) {
          return Obx(() {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: const MonthCalender(),
              ),
              body: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.transactions.length + 1,
                  itemBuilder: (context, pos) {
                    if (pos == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: MonthlyStatsWidget(
                            monthlyStats: controller.monthlyStats),
                      );
                    }
                    return DateListItem(
                        date: controller.transactions.keys.elementAt(pos - 1),
                        transactions:
                            controller.transactions.values.elementAt(pos - 1));
                  }),
              floatingActionButton: Fab(onTap: () {
                Get.to(() => NewTransaction());
              }),
            );
          });
        },
      ),
    );
  }
}
