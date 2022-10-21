import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  Widget passedWidget;

  TextInputField({super.key, required this.passedWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            backgroundColor: Theme.of(context).canvasColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            side: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: passedWidget,
          )),
    );
  }
}
