import 'package:flutter/material.dart';

class Fab extends StatelessWidget {
  const Fab({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xff03dac6),
      onPressed: onTap,
      tooltip: 'Increment',
      child: const Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }
}
