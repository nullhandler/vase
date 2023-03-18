class Const {
  static const accounts = "Accounts";
  static const trans = "Transactions";
  static const categories = "Categories";
}

extension VsString on String {
  String get toCamelCase {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String get toSnakeCase {
    return replaceAllMapped(RegExp(r'([A-Z])'), (match) => "_${match.group(0)!.toLowerCase()}");
  }

  String get toPascalCase {
    return replaceAllMapped(
        RegExp(r'(\w+)'), (match) => "${match.group(0)![0].toUpperCase()}${match.group(0)!.substring(1)}");
  }

  String get toKebabCase {
    return replaceAllMapped(RegExp(r'(\w+)'), (match) => "${match.group(0)!.toLowerCase()}-");
  }

  String get toTitleCase {
    return replaceAllMapped(RegExp(r'(\w+)'),
        (match) => "${match.group(0)![0].toUpperCase()}${match.group(0)!.substring(1).toLowerCase()} ");
  }
}
