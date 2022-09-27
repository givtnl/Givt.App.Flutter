import 'package:flutter/material.dart';

class BarButtonBasic extends StatelessWidget {
  final String title;
  final Widget where;
  const BarButtonBasic({super.key, required this.title, required this.where});

  // should this widget actually take more then the route target?
  void navigate(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => where),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: InkWell(
        splashColor: Theme.of(context).textTheme.bodyText1?.color,
        onTap: () => navigate(context),
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
