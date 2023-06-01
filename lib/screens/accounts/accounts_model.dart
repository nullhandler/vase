// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

Map<int, Account> accountsFromJson(List<Map<String, Object?>> list) =>
    Map<int, Account>.fromEntries(list.map((x) {
      Account account = Account.fromJson(x);
      return MapEntry(account.id!, account);
    }));

String accountsToJson(List<Account> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
  Account(
      {this.id,
      required this.accountName,
      required this.accountType,
      this.parentId});

  int? id;
  String accountName;
  AccountType accountType;
  int? parentId;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
      id: json["id"],
      accountName: json["account_name"],
      accountType: AccountType.values[json["account_type"]],
      parentId: json["parent_id"]);

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        "account_name": accountName,
        "account_type": accountType.index,
        if (parentId != null) "parent_id": parentId
      };

  @override
  String toString() => accountName;

  bool hasParentAccount() {
    return parentId != null;
  }
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

class TotalAccountStat {
  double assets = 0;
  double liabilities = 0;
  double total = 0;
}
