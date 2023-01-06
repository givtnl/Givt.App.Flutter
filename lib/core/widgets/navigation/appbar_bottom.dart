import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import '../../../core/constants/route_paths.dart' as routes;

class BottomBarCustom extends StatelessWidget {
  late final NavigationService _navigationService =
      locator<NavigationService>();
  BottomBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Theme.of(context).canvasColor,
        child: SizedBox(
          height: 75,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 8, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //   child: Column(
                //     children: [
                //       SizedBox(
                //         height: 40,
                //         child: IconButton(
                //           padding: const EdgeInsets.all(0),
                //           tooltip: 'Curch overview',
                //           icon: SvgPicture.asset(
                //             'assets/svg/church.svg',
                //             height: 25,
                //           ),
                //           onPressed: () {},
                //           color: Theme.of(context).textTheme.bodyText1?.color,
                //         ),
                //       ),
                //       Text(
                //         'my church',
                //         style: Theme.of(context).textTheme.subtitle2?.copyWith(
                //               fontSize: 12,
                //             ),
                //       )
                //     ],
                //   ),
                // ),
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
                          onPressed: () => _navigationService
                              .navigateTo(routes.OverviewRoute),
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
                          tooltip: 'Profile',
                          icon: SvgPicture.asset(
                            'assets/svg/user.svg',
                            height: 25,
                          ),
                          onPressed: () =>
                              // this should check whether user is logged in
                              _navigationService.navigateTo(routes.LoginRoute),
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
