import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/controllers/db_controller.dart';

class AccountsScreen extends StatelessWidget {
  AccountsScreen({Key? key}) : super(key: key);
  final DbController dbController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: dbController.accounts.length,
        itemBuilder: (context, pos) {
          return Text(dbController.accounts[pos].accountName);
        });
  }
}
