Map<int, AccountStats> accountStatsFromJson(List<Map<String, Object?>> list) =>
    Map<int, AccountStats>.fromEntries(list.map((e) {
      AccountStats accountStats = AccountStats.fromJson(e);
      return MapEntry(accountStats.id, accountStats);
    }));

class AccountStats {
  double expense;
  double income;
  int id;

  AccountStats({
    required this.expense,
    required this.income,
    required this.id,
  });

  factory AccountStats.fromJson(Map<String, dynamic> json) => AccountStats(
        id: json["account_id"],
        income: json["income"].toDouble(),
        expense: json["expense"].toDouble(),
      );
}
