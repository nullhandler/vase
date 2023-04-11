class UserModel {
  UserModel({
    this.id,
    required this.currency,
    required this.thousandSeparator,
    required this.decimalSeparator
  });

  int? id;
  String currency;
  String thousandSeparator;
  String decimalSeparator;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        currency: json["currency"],
      thousandSeparator: json['thousand_separator'] ,
      decimalSeparator: json['decimal_separator']
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        "currency": currency,
        "thousand_separator" : thousandSeparator,
        "decimal_separator" : decimalSeparator
      };

  @override
  String toString() {
    return currency;
  }
}
