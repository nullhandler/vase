import 'dart:math';

import 'package:flutter/material.dart';

class Sector {
  Sector(
      {required this.colorCode,
      required this.color,
      required this.total,
      required this.share,
      required this.title});

  int? colorCode;
  Color color;
  double total;
  int share;
  String title;

  factory Sector.fromJson(Map<String, dynamic> json) => Sector(
        colorCode: json['color'],
        color: json['color'] != null
            ? Color(json['color'])
            : Colors.primaries[Random().nextInt(Colors.primaries.length)],
        title: json['category_name'].length > 10
            ? json['category_name'].substring(0, 9)
            : json['category_name'],
        share: json['share'],
        total: json['total'],
      );
}
