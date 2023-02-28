import 'package:flutter/material.dart';

/// Transparent InkWell
class TinkWell extends StatelessWidget {
  const TinkWell({Key? key, required this.child, required this.onTap})
      : super(key: key);
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
