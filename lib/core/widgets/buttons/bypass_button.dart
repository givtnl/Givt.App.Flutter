import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/themes/primary_theme.dart';

class BypassBtn extends StatelessWidget {
  final String title;
  final String where;
  const BypassBtn({
    super.key,
    required this.title,
    required this.where,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushReplacementNamed(context, where),
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
