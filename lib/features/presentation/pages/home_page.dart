import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';
import 'package:givt_mobile_apps/features/presentation/components/core/navigation/appbar_bottom.dart';
import 'package:givt_mobile_apps/features/presentation/components/pages/home/button_add_charity.dart';
import 'package:givt_mobile_apps/features/presentation/components/core/buttons/button_center_float.dart';
import 'package:givt_mobile_apps/features/presentation/components/core/buttons/button_square.dart';
import 'package:givt_mobile_apps/features/presentation/components/core/buttons/button_square_updt.dart';
import 'package:givt_mobile_apps/features/presentation/components/pages/home/card_of_organization.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Palette.background,
        elevation: 0,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Image(image: AssetImage('assets/images/logo.png')),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SquareButtonE(
              title: "scan Qr code",
              iconName: 'qr_code',
              background: Palette.darkBlue,
            ),
            SquareButtonE(
              title: "collection device nearby",
              iconName: 'connection',
              background: Palette.deepPurple,
            ),
          ],
        ),
        const CardOrganization(),
        const AddFaveOrgButton(),
      ]),
      floatingActionButton: const CenteredFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBarCustom(),
    );
  }
}
