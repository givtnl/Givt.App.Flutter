import 'package:flutter/material.dart';

import 'package:givt_mobile_apps/core/constants/palette.dart';

class BarButtonPermissions extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const BarButtonPermissions({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.mintGreen,
      child: InkWell(
        splashColor: Palette.darkBlue,
        onTap: () => onPressed(),
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

  
// I was trying to make it as an elevated button but the styling was a pain, 
// the abothe thing works anw

// ElevatedButton(
//                       onPressed: () =>
//                           isPermanent ? openAppSettings() : onPressed(),
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all(Palette.mintGreen),
//                         textStyle: MaterialStateProperty.all(TextStyle(
//                             color: Palette.white,
//                             fontSize: 23,
//                             fontWeight: FontWeight.w700)),
//                       ),
//                       child: Text(isPermanent ? 'Open settings' : 'Allow access'),
//                     ),