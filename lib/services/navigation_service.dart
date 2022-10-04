// This class can be used to navigate without the BuildContext.
// This allows us to navigate from within our controllers where the business logic lies.
// This way we DON'T have to direct back to your UI code where the context is available
// and adding business logic within our view.

import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
