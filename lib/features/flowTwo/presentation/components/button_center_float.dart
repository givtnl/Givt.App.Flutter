import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';

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
                Icon(
                  Icons.volunteer_activism,
                  size: 25,
                  color: Palette.greyBlueTone,
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
