import 'package:flutter/material.dart';

class Sector {
  Sector(
      {required this.color,
      required this.total,
      required this.share,
      required this.title});

  Color color;
  double total;
  int share;
  String title;

  factory Sector.fromJson(Map<String, dynamic> json) => Sector(
        color: Colors.blue,
        title: json['category_name'],
        share: json['share'],
        total: json['total'],
      );
}
