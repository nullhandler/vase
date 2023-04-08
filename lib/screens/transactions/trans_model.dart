// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

List<Transaction> transactionFromJson(List<Map<String, Object?>> list) =>
    List<Transaction>.from(list.map((x) => Transaction.fromJson(x)));

double totalFromJson(List<Map<String, dynamic>> list) {
  double total = 0.0;
  total = list.fold(0, (i, el){
    return i + el['amount'];
  });
  return total;
}

String transactionToJson(List<Transaction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transaction {
  Transaction({
    this.id,
    required this.createdAt,
    required this.amount,
    required this.desc,
    required this.accountId,
    this.categoryId,
  });

  int? id;
  DateTime createdAt;
  double amount;
  String desc;
  int accountId;
  int? categoryId;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        createdAt: DateTime.fromMillisecondsSinceEpoch(json["created_at"]),
        amount: json["amount"]?.toDouble(),
        desc: json["desc"],
        accountId: json["account_id"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        "created_at": createdAt.millisecondsSinceEpoch,
        "amount": amount,
        "desc": desc,
        "account_id": accountId,
        if (categoryId != null) "category_id": categoryId,
      };
}
