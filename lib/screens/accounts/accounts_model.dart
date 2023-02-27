// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

List<Account> accountsFromJson(List<Map<String, Object?>> list) => List<Account>.from(list.map((x) => Account.fromJson(x)));

String accountsToJson(List<Account> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
  Account({
    required this.id,
    required this.accountName,
  });

  int id;
  String accountName;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    id: json["id"],
    accountName: json["account_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "account_name": accountName,
  };
}
