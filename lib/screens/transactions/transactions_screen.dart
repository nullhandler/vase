import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vase/colors.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/extensions.dart';
import 'package:vase/screens/categories/category_model.dart';
import 'package:vase/utils.dart';
import 'package:vase/widgets/wrapper.dart';

import '../widgets/fab.dart';
import '../widgets/month_calender.dart';
import 'new_transaction.dart';
import 'trans_controller.dart';
import 'trans_model.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      child: GetBuilder<TransController>(
        builder: (TransController controller) {
          return Obx(() {
            double dailyTotals = 0;
            int sameDayIx = 0;

            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: const MonthCalender(),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      controller.monthlyTotal.string,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.transactions.length,
                    itemBuilder: (context, pos) {
                      Transaction transaction = controller.transactions[pos];
                      Transaction? prevTxn;
                      bool addDateSeparator = false;
                      dailyTotals = 0;

                      if (pos == 0) {
                        addDateSeparator = false;
                        // dailyTotals = controller.transactions[pos].amount;
                      } else {
                        prevTxn = controller.transactions[pos - 1];
                        addDateSeparator =
                            transaction.createdAt.isSameDate(prevTxn.createdAt);
                        if (!addDateSeparator) {
                          while (sameDayIx < pos) {
                            dailyTotals +=
                                controller.transactions[sameDayIx].amount;
                            sameDayIx++;
                          }
                        } else {
                          dailyTotals = 0;
                        }
                      }

                      Category? cat;
                      try {
                        cat = Get.find<DbController>().categories.firstWhere(
                              (element) => element.id == transaction.categoryId,
                            );
                      } catch (e) {
                        debugPrint('error in cat');
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (pos == 0 || !addDateSeparator)
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Utils.dateChip(
                                      DateFormat.yMMMMd('en_US')
                                          .format(transaction.createdAt),
                                      AppColors.darkGreyColor,
                                      dailyTotals.toString()),
                                )
                              : const SizedBox(),
                          ListTile(
                              leading: CircleAvatar(
                                // backgroundColor: AppColors.darkGreyColor,
                                child: Icon(deserializeIcon({
                                  'pack': 'cupertino',
                                  'key': cat != null
                                      ? cat.icon
                                      : 'money_dollar_constant'
                                })),
                              ),
                              title: Text(transaction.desc),
                              subtitle: Text(
                                DateFormat.yMMMMd('en_US')
                                    .format(transaction.createdAt),
                                style: const TextStyle(color: Colors.grey),
                              ),
                              trailing: Text(
                                '${transaction.amount}',
                                style: TextStyle(
                                  color: transaction.amount.isNegative
                                      ? AppColors.errorColor
                                      : AppColors.accentColor,
                                ),
                              )),
                        ],
                      );
                    }),
              ),
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
