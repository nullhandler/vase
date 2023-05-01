import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/screens/accounts/accounts_controller.dart';
import 'package:vase/screens/widgets/txn_text.dart';
import 'package:vase/widgets/heading.dart';

import 'accounts_model.dart';

class AccountList extends StatelessWidget {
  const AccountList({Key? key, required this.accountsMap}) : super(key: key);

  final RxMap<AccountType, List<Account>> accountsMap;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
          itemCount: accountsMap.length,
          shrinkWrap: true,
          itemBuilder: (context, pos) {
            List<Account> accounts = accountsMap.values.elementAt(pos);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Heading(
                      title: accountTypeMap[accountsMap.keys.elementAt(pos)] ??
                          ""),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    margin: const EdgeInsets.all(0),
                    child: ListView.builder(
                        itemCount: accounts.length,
                        shrinkWrap: true,
                        itemBuilder: (context, pos) {
                          return AccountListItem(account: accounts[pos]);
                        }),
                  ),
                ],
              ),
            );
          });
    });
  }
}

class AccountListItem extends StatelessWidget {
  const AccountListItem({Key? key, required this.account}) : super(key: key);
  final Account account;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(account.accountName),
          TxnText(
              amount:
                  Get.find<AccountsController>().accountStats[account.id] ?? 0)
        ],
      ),
    );
  }
}
