import 'package:flutter/material.dart';

class FormItem extends StatelessWidget {
  const FormItem(
      {Key? key, required this.question, required this.controller, this.onTap})
      : super(key: key);
  final String question;
  final TextEditingController controller;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: controller,
              readOnly: onTap != null,
              onTap: onTap,
              style: Theme.of(context).inputDecorationTheme.counterStyle,
              decoration: InputDecoration(
                  labelText: question,
                  border: const OutlineInputBorder(),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  isDense: false),
            ),
          )
        ],
      ),
    );
  }
}