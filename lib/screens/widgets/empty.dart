import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key, required this.assetName, required this.label})
      : super(key: key);
  final String assetName;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            assetName,
            semanticsLabel: 'No Data',
            height: 200,
            width: 200,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(label)
        ],
      ),
    );
  }
}
