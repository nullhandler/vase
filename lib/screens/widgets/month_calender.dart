import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:vase/screens/transactions/trans_controller.dart';
import 'package:vase/screens/widgets/tinkwell.dart';

class MonthCalender extends StatelessWidget {
  const MonthCalender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransController>(
      builder: (controller) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                controller.goToPreviousMonth();
              },
              icon: const Icon(Icons.chevron_left_rounded)),
          TinkWell(
            child: Obx(() {
              return Text(
                  DateFormat("MMM y").format(controller.currentDate.value));
            }),
            onTap: () async {
              final DateTime? dateTime = await showMonthPicker(
                  context: context,
                  initialDate: controller.currentDate.value,
                  firstDate: DateTime(2000, 2, 13),
                  lastDate: DateTime(2100, 2, 13));
              controller.setDate(dateTime);
            },
          ),
          IconButton(
              onPressed: () {
                controller.goToNextMonth();
              },
              icon: const Icon(Icons.chevron_right_rounded))
        ],
      ),
    );
  }
}
