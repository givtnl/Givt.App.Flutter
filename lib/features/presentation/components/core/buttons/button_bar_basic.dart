import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';

class BarButtonBasic extends StatelessWidget {
  final String title;
  const BarButtonBasic({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.mintGreen,
      child: InkWell(
        splashColor: Palette.darkBlue,
        onTap: () {},
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 13.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Palette.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
