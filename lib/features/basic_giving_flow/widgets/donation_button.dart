import 'dart:math';

import 'package:flutter/material.dart';

class DonationButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  bool? filled;
  bool? bold;
  DonationButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.filled = false,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: !filled!
                ? (const Color.fromARGB(0, 155, 155, 155))
                : (Theme.of(context).colorScheme.tertiary),
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
            child: Center(
              child: Text(
                label,
                style: !bold!
                    ? (Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 11))
                    : (Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontWeight: FontWeight.w800, fontSize: 16)),
              ),
            ),
          )),
    );
  }
}
