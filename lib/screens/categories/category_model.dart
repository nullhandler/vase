// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

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
      required this.isDeleted});

  int? id;
  String categoryName;
  CategoryType categoryType;
  DateTime? createdAt;
  String icon;
  int isDeleted;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json["id"],
        categoryName: json["category_name"],
        categoryType:
            categoryTypeMap[json["category_type"]] ?? CategoryType.expense,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        icon: json['icon'],
        isDeleted: json['is_deleted']??0);
  }

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        "category_name": categoryName,
        "category_type": categoryType.name,
        if (createdAt != null) "created_at": createdAt!.toIso8601String(),
        "icon": icon,
        "is_deleted": isDeleted
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
