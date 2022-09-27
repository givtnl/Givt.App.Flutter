import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBarCustom extends StatelessWidget {
  const BottomBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Theme.of(context).backgroundColor,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
              tooltip: 'my church overview',
              icon: SvgPicture.asset('assets/svg/church.svg'),
              //icon: const Icon(Icons.church),
              onPressed: () {},
              color: Theme.of(context).textTheme.bodyText1?.color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
              tooltip: 'my profile',
              icon: SvgPicture.asset('assets/svg/user.svg'),
              onPressed: () {},
              color: Theme.of(context).textTheme.bodyText1?.color,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
              tooltip: 'Search',
              icon: SvgPicture.asset('assets/svg/overview.svg'),
              onPressed: () {},
              color: Theme.of(context).textTheme.bodyText1?.color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: IconButton(
              tooltip: 'Favorite',
              icon: SvgPicture.asset('assets/svg/settings.svg'),
              onPressed: () {},
              color: Theme.of(context).textTheme.bodyText1?.color,
            ),
          ),
        ],
      ),
    );
  }
}
