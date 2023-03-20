import 'package:flutter/material.dart';

class MonthCalender extends StatelessWidget {
  const MonthCalender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.chevron_left_rounded)),
        const Text("Cal"),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.chevron_right_rounded))
      ],
    );
  }
}
