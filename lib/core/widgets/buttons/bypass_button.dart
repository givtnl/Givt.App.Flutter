import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/theme/theme.dart';

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
      onPressed: () => Navigator.pushNamed(context, where),
      child: Text(
        title,
        style: TextStyle(
          color: AppTheme.theme.textDark,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
          decorationThickness: 1.5,
        ),
      ),
    );
  }
}
