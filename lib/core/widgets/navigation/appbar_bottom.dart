import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBarCustom extends StatelessWidget {
  const BottomBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      // BorderRadius.all(Radius.circular(30)),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Theme.of(context).canvasColor,
        child: SizedBox(
          height: 75,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 8, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          tooltip: 'Curch overview',
                          icon: SvgPicture.asset(
                            'assets/svg/church.svg',
                            height: 25,
                          ),
                          onPressed: () {},
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
                      ),
                      Text(
                        'my church',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              fontSize: 12,
                            ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          tooltip: 'Profile',
                          icon: SvgPicture.asset(
                            'assets/svg/user.svg',
                            height: 25,
                          ),
                          onPressed: () {},
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
                      ),
                      Text(
                        'profile',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              fontSize: 12,
                            ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          tooltip: 'Give',
                          icon: SvgPicture.asset(
                            'assets/svg/giving_hand.svg',
                            height: 31,
                          ),
                          onPressed: () {},
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
                      ),
                      Text(
                        'give',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              fontSize: 12,
                            ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          tooltip: 'Overview',
                          icon: SvgPicture.asset(
                            'assets/svg/overview.svg',
                            height: 20,
                          ),
                          onPressed: () {},
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
                      ),
                      Text(
                        'overview',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              fontSize: 12,
                            ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          tooltip: 'Settings',
                          icon: SvgPicture.asset(
                            'assets/svg/settings.svg',
                          ),
                          onPressed: () {},
                          color: Theme.of(context).textTheme.bodyText1?.color,
                        ),
                      ),
                      Text(
                        'settings',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              fontSize: 12,
                            ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
