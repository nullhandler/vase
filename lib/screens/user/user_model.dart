class UserModel {
  UserModel({
    this.id,
    required this.currency,
    required this.thousandSeparator,
    required this.decimalSeparator,
    required this.monet
  });

  int? id;
  String currency;
  String thousandSeparator;
  String decimalSeparator;
  bool monet;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        currency: json["currency"],
      thousandSeparator: json['thousand_separator'] ,
      decimalSeparator: json['decimal_separator'],
      monet: json['monet']=='true'?true:false
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        "currency": currency,
        "thousand_separator" : thousandSeparator,
        "decimal_separator" : decimalSeparator,
        "monet": monet
      };

  @override
  String toString() {
    return currency;
  }
}
