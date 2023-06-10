class UserModel {
  UserModel(
      {required this.currency,
      required this.thousandSeparator,
      required this.decimalSeparator,
      required this.monet,
      required this.newUser});

  String currency;
  String thousandSeparator;
  String decimalSeparator;
  bool monet;
  bool newUser;

  static const currencyConst = "currency";
  static const thousandSeparatorConst = "thousandSeparator";
  static const decimalSeparatorConst = "decimalSeparator";
  static const monetConst = "monet";
  static const newUserConst = "newUser";

  factory UserModel.fromJson(List<Map<String, dynamic>> json) {
    Map<String, dynamic> map =
        Map.fromEntries(json.map((e) => MapEntry(e['key'], e['value'])));
    return UserModel(
        currency: map[currencyConst] ?? r'₹',
        thousandSeparator: map[thousandSeparatorConst] ?? ',',
        decimalSeparator: map[decimalSeparatorConst] ?? '.',
        monet: map[monetConst] == 'true',
        newUser: json.isEmpty ? true : map[newUserConst] == 'true');
  }

  Map<String, dynamic> toJson() => {
        "currency": currency,
        "thousand_separator": thousandSeparator,
        "decimal_separator": decimalSeparator,
        "monet": monet,
        "newUser": newUser
      };

  @override
  String toString() {
    return currency;
  }
}
