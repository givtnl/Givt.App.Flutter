import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_mobile_apps/features/presentation/components/core/buttons/button_bar_basic.dart';
import 'package:givt_mobile_apps/features/presentation/components/pages/usp/benefit_row.dart';
import 'package:givt_mobile_apps/features/presentation/pages/camera_permission_page.dart';
import 'package:givt_mobile_apps/features/presentation/pages/location_permission_page.dart';

class UspPage extends StatelessWidget {
  const UspPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
            child: SvgPicture.asset('assets/svg/logo.svg'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Benefits of Givt',
                  style: TextStyle(
                    color: Palette.darkBlue,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 15),
                const UspRow(benefit: 'Giving in the moment'),
                const UspRow(benefit: 'Give to any church or charity'),
                const UspRow(
                    benefit:
                        'One tax statement by Givt even if you\'re giving anonymously'),
                const UspRow(benefit: 'See all your donations in one place'),
                const UspRow(benefit: 'Manage recurring donations'),
                const UspRow(benefit: 'Safe and secure giving')
              ],
            ),
          ),
          const SizedBox(height: 45),
          const Padding(
            padding: EdgeInsets.fromLTRB(35, 0, 35, 45),
            child: BarButtonBasic(
              title: 'Give now',
              where: CameraPermissionPage(),
            ),
          )
        ],
      ),
    );
  }
}
