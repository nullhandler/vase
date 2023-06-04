class TransStats {
  double income;
  double expense;
  double total;

  TransStats(this.income, this.expense, this.total);
}

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
  int? toAccountId;

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
