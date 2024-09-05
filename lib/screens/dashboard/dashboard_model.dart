import 'dart:math';

import 'package:flutter/material.dart';

class Sector {
  Sector(
      {required this.color,
      required this.amount,
      required this.share,
      required this.title,
      required this.icon,
      this.include = true});

  Color color;
  double amount;
  int share;
  String title;
  String icon;
  bool include;

  factory Sector.fromJson(Map<String, dynamic> json) => Sector(
      color: json['color'] != null
          ? Color(json['color'])
          : Colors.primaries[Random().nextInt(Colors.primaries.length)],
      title: json['category_name'],
      share: json['share'],
      amount: json['total'],
      icon: json['icon']);

  void switchInclusion() {
    include = !include;
  }

  String totalPercent(double total) {
    if (!include) return "0";
    return ((amount / total) * 100).toStringAsFixed(2);
  }
}
