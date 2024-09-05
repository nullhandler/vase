import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'screens/user/user_controller.dart';

extension DateExtension on DateTime {
  DateTime copyTime(TimeOfDay from) {
    return DateTime(year, month, day, from.hour, from.minute);
  }

  bool isSameDate(DateTime other) {
    return isSameMonth(other) && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
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
            "${match.group(0)![0].toUpperCase()}${match.group(0)!.substring(1).toLowerCase()} ");
  }
}

extension VsDouble on double {
  String get n {
    final controller = Get.find<UserController>();
    final comma = controller.thousandSep.value;
    final decimal = controller.decimalSep.value;
    var f = NumberFormat.simpleCurrency(locale: 'en-us');
    String amt = f.format(this);
    amt = amt.replaceAll('\$', '');
    if (decimal == 1 && comma == 0) {
      amt = amt.replaceAll('.', '@');
      amt = amt.replaceAll(',', '.');
      amt = amt.replaceAll('@', ',');
    } else if (comma == 0 && decimal == 0) {
      amt = amt.replaceAll(',', '.');
    } else if (comma == 1 && decimal == 1) {
      amt = amt.replaceAll('.', ',');
    }
    return controller.currency.value + amt;
  }

  String get s {
    return n.replaceFirst('-', '');
  }
}
