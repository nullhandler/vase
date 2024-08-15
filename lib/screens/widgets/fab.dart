import 'package:flutter/material.dart';

class Fab extends StatelessWidget {
  const Fab({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      // backgroundColor: AppColors.accentColor,
      onPressed: onTap,
      tooltip: 'Increment',
      child: const Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }
}
