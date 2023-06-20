// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

List<Category> categoryFromJson(List<Map<String, Object?>> list) =>
    List<Category>.from(
      list.map((x) => Category.fromJson(x)),
    );

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map(
      (x) => x.toJson(),
    )));

class Category {
  Category(
      {this.id,
      required this.categoryName,
      required this.categoryType,
      this.createdAt,
      required this.icon,
      required this.isDeleted,
      required this.color});

  int? id;
  String categoryName;
  CategoryType categoryType;
  DateTime? createdAt;
  String icon;
  int isDeleted;
  Color color;

  factory Category.fromJson(Map<String, dynamic> json) {
    Color categoryColor;
    if (json['color'] != null) {
      categoryColor = Color(json['color']);
    } else {
      categoryColor = Colors.red;
    }
    return Category(
        id: json["id"],
        categoryName: json["category_name"],
        categoryType:
            categoryTypeMap[json["category_type"]] ?? CategoryType.expense,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        icon: json['icon'],
        color: categoryColor,
        isDeleted: json['is_deleted'] ?? 0);
  }

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        "category_name": categoryName,
        "category_type": categoryType.name,
        if (createdAt != null) "created_at": createdAt!.toIso8601String(),
        "icon": icon,
        "is_deleted": isDeleted,
        "color": color.value,
      };

  @override
  String toString() {
    return categoryName;
  }
}

Map<String, CategoryType> categoryTypeMap = {
  "expense": CategoryType.expense,
  "income": CategoryType.income,
};

enum CategoryType { expense, income, transfer }
