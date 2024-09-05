import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vase/screens/transactions/date_chip.dart';
import 'package:vase/screens/transactions/new_transaction.dart';
import 'package:vase/screens/transactions/trans_controller.dart';
import 'package:vase/text_styles.dart';
import 'package:vase/widgets/category_icon.dart';

import '../../controllers/db_controller.dart';
import '../categories/category_model.dart';
import '../widgets/txn_text.dart';
import 'trans_model.dart';

class DateListItem extends StatelessWidget {
  final String date;
  final List<Transaction> transactions;
  final bool isSearch;

  const DateListItem(
      {super.key,
      required this.date,
      required this.transactions,
      this.isSearch = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isSearch)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: DateChip(
              label: date,
              transStats: Get.find<TransController>().dailyStats[date],
            ),
          ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: transactions.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, pos) {
              Transaction transaction = transactions[pos];

              Category? cat;
              try {
                cat = Get.find<DbController>().categories.firstWhere(
                      (element) => element.id == transaction.categoryId,
                    );
              } catch (e) {
                debugPrint('error in cat');
              }
              return ListTile(
                  onTap: () {
                    if (isSearch) {
                      Get.off(() => NewTransaction(), arguments: {
                        "edit": true,
                        "transaction": transaction
                      });
                    } else {
                      Get.to(() => NewTransaction(), arguments: {
                        "edit": true,
                        "transaction": transaction
                      });
                    }
                  },
                  leading: CategoryIcon(icon: cat?.icon ?? 'ban'),
                  title: Text(
                    transaction.desc,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (Get.find<DbController>()
                                    .accounts[transaction.accountId]
                                    ?.accountName ??
                                "") +
                            (transaction.toAccountId != null
                                ? " -> ${Get.find<DbController>().accounts[transaction.toAccountId]?.accountName ?? ""}"
                                : "") +
                            (cat?.categoryName != null
                                ? " • ${cat?.categoryName}"
                                : ""),
                        style: secondaryTextStyle,
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TxnText(
                        amount: transaction.amount,
                        showDynamicColor: transaction.toAccountId == null,
                      ),
                      Text(
                        isSearch
                            ? DateFormat('dd-MM-yyyy | hh:mm a')
                                .format(transaction.createdAt)
                            : DateFormat.jm('en_US')
                                .format(transaction.createdAt),
                        style: secondaryTextStyle,
                      )
                    ],
                  ));
            },
          ),
        ),
      ],
    );
  }
}
