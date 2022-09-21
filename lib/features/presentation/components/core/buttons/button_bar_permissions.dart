import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:givt_mobile_apps/core/constants/palette.dart';
import 'package:givt_mobile_apps/features/presentation/pages/location_permission_page.dart';
import 'package:givt_mobile_apps/features/presentation/pages/usp.dart';

class BarButtonPermissions extends StatelessWidget {
  final String title;
  // since we are not calling navigate then this might be useless. lets cheeeck
  //final Widget where;
  final bool isPermanent;
  final VoidCallback onPressed;
  const BarButtonPermissions(
      {super.key,
      required this.onPressed,
      required this.title,
      //required this.where,
      required this.isPermanent});

  // since we are not calling navigate then this might be useless. lets cheeeck
  // should this widget actually take more then the route target?
  // void navigate(context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => where),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.mintGreen,
      child: InkWell(
        splashColor: Palette.darkBlue,
        onTap: () {
          isPermanent ? openAppSettings() : onPressed();
        },
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 13.0),
            child: Text(
              isPermanent ? 'Open Settings' : title,
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
                    //   onPressed: () =>
                    //       isPermanent ? openAppSettings() : onPressed(),
                    //   style: ButtonStyle(
                    //     backgroundColor:
                    //         MaterialStateProperty.all(Palette.mintGreen),
                    //     textStyle: MaterialStateProperty.all(TextStyle(
                    //         color: Palette.white,
                    //         fontSize: 23,
                    //         fontWeight: FontWeight.w700)),
                    //   ),
                    //   child: Text(isPermanent ? 'Open settings' : 'Allow access'),
                    // ),