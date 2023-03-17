// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(List<Map<String, Object?>> list) =>
    List<Category>.from(list.map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    required this.categoryName,
    required this.categoryType,
  });

  int? id;
  String categoryName;
  CategoryType categoryType;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryName: json["category_name"],
        categoryType:
            categoryTypeMap[json["category_type"]] ?? CategoryType.expense,
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        "category_name": categoryName,
        "category_type": categoryType.name,
      };
}

Map<String, CategoryType> categoryTypeMap = {
  "expense": CategoryType.expense,
  "income": CategoryType.income
};

enum CategoryType { expense, income }
