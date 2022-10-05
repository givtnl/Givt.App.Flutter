import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/route_paths.dart' as routes;
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';

class BypassBtn extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  final String title;
  final dynamic where;
  BypassBtn({
    super.key,
    required this.title,
    required this.where,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // differently
      onPressed: () => _navigationService.navigateTo(where),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1?.color,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
          decorationThickness: 1.5,
        ),
      ),
    );
  }
}
