import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vase/colors.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/screens/categories/category_model.dart';
import 'package:vase/screens/widgets/txn_text.dart';
import 'package:vase/utils.dart';
import 'package:vase/widgets/wrapper.dart';
import '../widgets/fab.dart';
import '../widgets/month_calender.dart';
import 'new_transaction.dart';
import 'trans_controller.dart';
import 'trans_model.dart';
import 'package:collection/collection.dart';

class Transactions extends StatelessWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      child: GetBuilder<TransController>(
        builder: (TransController controller) {
          return Obx(() {
            final txns = groupBy(
                controller.transactions,
                (Transaction txn) =>
                    DateFormat.yMMMMd('en_US').format(txn.createdAt));

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
                    itemCount: txns.entries.length,
                    itemBuilder: (context, pos) {
                      List<Transaction> transactions =
                          txns.values.elementAt(pos);

                      double total = 0;

                      for (int i = 0; i < transactions.length; i++) {
                        total += transactions[i].amount;
                      }
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Utils.dateChip(txns.keys.elementAt(pos),
                                AppColors.darkGreyColor, total),
                          ),
                          Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: transactions.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, ix) {
                                Transaction transaction = transactions[ix];

                                Category? cat;
                                try {
                                  cat = Get.find<DbController>()
                                      .categories
                                      .firstWhere(
                                        (element) =>
                                            element.id ==
                                            transaction.categoryId,
                                      );
                                } catch (e) {
                                  debugPrint('error in cat');
                                }

                                return ListTile(
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
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    trailing: TxnText(
                                      amount: transaction.amount,

                                    ));
                              },
                            ),
                          ),
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
