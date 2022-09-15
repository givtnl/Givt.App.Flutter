import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';

class SquareButtonE extends StatelessWidget {
  final String title;
  final Icon icon;
  final Color background;
  const SquareButtonE(
      {super.key,
      required this.title,
      required this.icon,
      required this.background});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: background,
        child: ClipRRect(
          //this is for the inkwell, otherwithe it bleeds over the rounded corners.
          borderRadius: BorderRadius.circular(40.0),
          child: InkWell(
            splashColor: Palette.murkyPink,
            onTap: () {
              //To be done
            },
            child: SizedBox(
              width: 100,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Palette.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
