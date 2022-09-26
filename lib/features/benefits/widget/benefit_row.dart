import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UspRow extends StatelessWidget {
  final String benefit;
  const UspRow({super.key, required this.benefit});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
          child: Icon(
            Icons.check_circle,
            color: Palette.mintGreen,
            size: 20.0,
          ),
        ),
        const SizedBox(width: 6),
        SizedBox(
          //this number needs to be refined prolly
          width: MediaQuery.of(context).size.width - 100,
          child: Text(
            benefit,
            style: TextStyle(
                color: Palette.darkBlue,
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}