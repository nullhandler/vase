import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountsDialog extends StatelessWidget {
  const AccountsDialog(
      {Key? key, required this.selectedAccount, required this.accounts})
      : super(key: key);
  final String selectedAccount;
  final List<String> accounts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: accounts.length,
        itemBuilder: (context, pos) {
          return InkWell(
            onTap: () {
              Get.back(result: accounts[pos]);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(accounts[pos]),
            ),
          );
        });
  }
}
