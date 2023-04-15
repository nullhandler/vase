import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  DateTime copyTime(TimeOfDay from) {
    return DateTime(year, month, day, from.hour, from.minute);
  }

  bool isSameDate(DateTime other) {
    return isSameMonth(other) &&
        day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year &&
        month == other.month;
  }

  String formatDate() {
    return DateFormat("dd-MM-yyyy").format(this);
  }

  String formatTime() {
    return DateFormat("hh:mm a").format(this);
  }
}

extension VsString on String {
  String get toCamelCase {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String get toSnakeCase {
    return replaceAllMapped(
        RegExp(r'([A-Z])'), (match) => "_${match.group(0)!.toLowerCase()}");
  }

  String get toPascalCase {
    return replaceAllMapped(
        RegExp(r'(\w+)'),
            (match) =>
        "${match.group(0)![0].toUpperCase()}${match.group(0)!.substring(1)}");
  }

  String get toKebabCase {
    return replaceAllMapped(
        RegExp(r'(\w+)'), (match) => "${match.group(0)!.toLowerCase()}-");
  }

  String get toTitleCase {
    return replaceAllMapped(
        RegExp(r'(\w+)'),
            (match) =>
        "${match.group(0)![0].toUpperCase()}${match.group(0)!
            .substring(1)
            .toLowerCase()} ");
  }
}
