import 'package:flutter/material.dart';
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
          SizedBox(
            height: 65,
            child: Column(
              children: [
                IconButton(
                  tooltip: 'my church overview',
                  icon: const Icon(Icons.church),
                  onPressed: () {},
                ),
                Text(
                  'church',
                  style: TextStyle(
                    color: Palette.greyBlue,
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'my profile',
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
          const Spacer(),
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.menu_outlined),
            onPressed: () {},
          ),
          IconButton(
            tooltip: 'Favorite',
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
