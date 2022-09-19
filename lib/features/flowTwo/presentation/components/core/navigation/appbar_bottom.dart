import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';

class BottomBarCustom extends StatelessWidget {
  const BottomBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Palette.background,
      child: Row(
        children: <Widget>[
          IconButton(
            tooltip: 'my church overview',
            icon: SvgPicture.asset('assets/svg/church.svg'),
            //icon: const Icon(Icons.church),
            onPressed: () {},
            color: Palette.darkBlue,
          ),
          IconButton(
            tooltip: 'my profile',
            icon: SvgPicture.asset('assets/svg/user.svg'),
            onPressed: () {},
            color: Palette.darkBlue,
          ),
          const Spacer(),
          IconButton(
            tooltip: 'Search',
            icon: SvgPicture.asset('assets/svg/overview.svg'),
            onPressed: () {},
            color: Palette.darkBlue,
          ),
          IconButton(
            tooltip: 'Favorite',
            icon: SvgPicture.asset('assets/svg/settings.svg'),
            onPressed: () {},
            color: Palette.darkBlue,
          ),
        ],
      ),
    );
  }
}
