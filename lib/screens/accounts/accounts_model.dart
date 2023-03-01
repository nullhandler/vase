// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

List<Account> accountsFromJson(List<Map<String, Object?>> list) =>
    List<Account>.from(list.map((x) => Account.fromJson(x)));

String accountsToJson(List<Account> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
  Account({this.id, required this.accountName, required this.accountType});

  int? id;
  String accountName;
  AccountType accountType;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
      id: json["id"],
      accountName: json["account_name"],
      accountType: AccountType.values[json["account_type"]]);

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        "account_name": accountName,
        "account_type": accountType.index
      };
}

enum AccountType { savings, card, credit }

Map<AccountType, String> accountTypeMap = {
  AccountType.savings: "Savings",
  AccountType.card: "Debit Card",
  AccountType.credit: "Credit Card"
};

AccountType accountTypeFromString(String s) {
  return accountTypeMap.keys.firstWhere(
      (element) => accountTypeMap[element] == s,
      orElse: () => AccountType.savings);
}

extension AccountTypeExt on AccountType {
  String toS() {
    return accountTypeMap[this] ?? "Savings";
  }
}
