import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';

class BarButtonOnCard extends StatelessWidget {
  final String title;
  const BarButtonOnCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      //this padding might be quite specific to design migth need to move it outside this definition
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11.0),
        child: Material(
          color: Palette.greyBlueTone,
          child: InkWell(
            splashColor: Palette.darkBlue,
            onTap: () {},
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13.0, vertical: 7.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Palette.darkBlue,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600),
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
