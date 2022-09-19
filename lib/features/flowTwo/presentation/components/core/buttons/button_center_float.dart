import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CenteredFloatingButton extends StatelessWidget {
  const CenteredFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85.0,
      width: 85.0,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: Palette.background,
          splashColor: Palette.murkyPink,
          onPressed: () {},
          tooltip: 'Create',
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/svg/giving_hand.svg',
                  semanticsLabel: 'no label',
                  //width: 20,
                  height: 30,
                ),
                Text(
                  'give',
                  style: TextStyle(
                    color: Palette.darkBlue,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
