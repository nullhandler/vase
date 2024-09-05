import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({super.key, required this.icon, this.bgColor});

  final String? icon;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: bgColor,
      child: SizedBox(
        width: 40,
        height: 20,
        child: Icon(
          deserializeIcon({'pack': 'fontAwesomeIcons', 'key': icon}),
          size: 20,
        ),
      ),
    );
  }
}
