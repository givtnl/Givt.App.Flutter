import 'package:flutter/material.dart';

class UspRow extends StatelessWidget {
  final String benefit;
  const UspRow({super.key, required this.benefit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
            child: Icon(
              Icons.check_circle,
              color: Theme.of(context).primaryColor,
              size: 20.0,
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            //this number needs to be refined prolly
            width: MediaQuery.of(context).size.width - 100,
            child: Text(
              benefit,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1?.color,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
