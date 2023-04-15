import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vase/screens/transactions/date_chip.dart';
import 'package:vase/screens/transactions/trans_controller.dart';
import 'package:vase/text_styles.dart';

import '../../controllers/db_controller.dart';
import '../categories/category_model.dart';
import '../widgets/txn_text.dart';
import 'trans_model.dart';

class DateListItem extends StatelessWidget {
  final String date;
  final List<Transaction> transactions;

  const DateListItem({Key? key, required this.date, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  leading: CircleAvatar(
                    // backgroundColor: AppColors.darkGreyColor,
                    child: Icon(deserializeIcon({
                      'pack': cat != null ? 'cupertino' : 'material',
                      'key': cat != null ? cat.icon : 'sync_alt_rounded'
                    })),
                  ),
                  title: Text(transaction.desc),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (Get.find<DbController>()
                                    .accounts[transaction.accountId]
                                    ?.accountName ??
                                "") +
                            (transaction.toAccountId != null
                                ? " -> ${Get.find<DbController>().accounts[transaction.accountId]?.accountName ?? ""}"
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
                        DateFormat.jm('en_US').format(transaction.createdAt),
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
