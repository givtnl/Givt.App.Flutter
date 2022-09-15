import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';

class SquareButton extends StatelessWidget {
  final String title;
  final Icon icon;
  final Color background;
  const SquareButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.background});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox.fromSize(
        size: const Size(100, 100), // button width and height
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Material(
            color: background, // button color
            child: InkWell(
              splashColor: Palette.murkyPink, // splash color
              onTap: () {}, // button pressed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  icon, // icon
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Palette.white,
                        fontSize: 11,
                      ),
                    ),
                  ), // text
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
