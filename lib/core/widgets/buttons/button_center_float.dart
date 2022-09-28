import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_mobile_apps/features/benefits/usp.dart';

class CenteredFloatingButton extends StatelessWidget {
  const CenteredFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85.0,
      width: 85.0,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor:
              Theme.of(context).floatingActionButtonTheme.backgroundColor,
          splashColor: Theme.of(context).floatingActionButtonTheme.splashColor,
          onPressed: () {
            // not the right rout or action, just temp stuff
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UspPage()),
            );
            //here we navigate to usp
          },
          tooltip: 'Create',
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/svg/giving_hand.svg',
                  semanticsLabel: 'no label',
                  //width: 20,
                  height: 30,
                ),
                Text(
                  'give',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
