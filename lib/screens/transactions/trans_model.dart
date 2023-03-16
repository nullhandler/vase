// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

import 'package:sqflite/sqflite.dart';

List<Transaction> transactionFromJson(List<Map<String, Object?>> list) =>
    List<Transaction>.from(list.map((x) => Transaction.fromJson(x)));

String transactionToJson(List<Transaction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transaction {
  Transaction({
    this.id,
    required this.createdAt,
    required this.amount,
    required this.desc,
    required this.accountId,
    required this.categoryId,
    this.toAccountId,
  });

  int? id;
  DateTime createdAt;
  double amount;
  String desc;
  int accountId;
  int categoryId;
  int? toAccountId;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        createdAt: DateTime.fromMillisecondsSinceEpoch(json["created_at"]),
        amount: json["amount"]?.toDouble(),
        desc: json["desc"],
        accountId: json["account_id"],
        categoryId: json["category_id"],
        toAccountId: json["to_account_id"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        "created_at": createdAt.millisecondsSinceEpoch,
        "amount": amount,
        "desc": desc,
        "account_id": accountId,
        "category_id": categoryId,
        if (toAccountId != null) "to_account_id": toAccountId
      };
}
