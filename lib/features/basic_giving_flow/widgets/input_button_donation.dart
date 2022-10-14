import 'dart:math';

import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  Widget child;
  InputButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            backgroundColor: Theme.of(context).canvasColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            side: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          child: SizedBox(
            width: min(130, 190),
            height: min(40, 80),
            // padding of a text box is dependant on fontsize inside...wtf
            // padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: child,
          )),
    );
  }
}
