import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountsDialog<S> extends StatelessWidget {
  const AccountsDialog(
      {Key? key, required this.selectedAccount, required this.accounts})
      : super(key: key);
  final S? selectedAccount;
  final List<S> accounts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (35 * accounts.length).toDouble(),
      width: double.maxFinite,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: accounts.length,
          itemBuilder: (context, pos) {
            return InkWell(
              onTap: () {
                Get.back(result: accounts[pos]);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(accounts[pos].toString()),
              ),
            );
          }),
    );
  }
}
