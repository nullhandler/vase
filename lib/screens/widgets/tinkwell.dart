import 'package:flutter/material.dart';

/// Transparent InkWell
class TinkWell extends StatelessWidget {
  const TinkWell({super.key, required this.child, required this.onTap});
  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: child,
    );
  }
}
