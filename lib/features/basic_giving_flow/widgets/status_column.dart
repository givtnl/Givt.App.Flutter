import 'package:flutter/material.dart';

class StatusColumn extends StatelessWidget {
  String lineOne;
  String? lineTwo;
  Color textColor;
  StatusColumn(
      {required this.textColor,
      required this.lineOne,
      this.lineTwo,
      super.key});
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(lineOne,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          )),
      (lineTwo != null)
          ? Text(lineTwo!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
              ))
          : const SizedBox(),
    ]);
  }
}
