import 'package:flutter/material.dart';

class BarButtonPermissions extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const BarButtonPermissions({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: InkWell(
        splashColor: Theme.of(context).textTheme.bodyText1?.color,
        onTap: () => onPressed(),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 13.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
