import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';
import 'package:givt_mobile_apps/features/permissions/pages/location_permission_page.dart';
import 'package:givt_mobile_apps/features/benefits/usp.dart';

class BarButtonBasic extends StatelessWidget {
  final String title;
  final Widget where;
  const BarButtonBasic({super.key, required this.title, required this.where});

  // should this widget actually take more then the route target?
  void navigate(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => where),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.mintGreen,
      child: InkWell(
        splashColor: Palette.darkBlue,
        onTap: () => navigate(context),
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
