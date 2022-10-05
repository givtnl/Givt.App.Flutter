import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final bool disabled;

  const GenericButton({
    Key? key,
    required this.text,
    required this.disabled,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor: disabled
              ? Theme.of(context).accentColor
              : Theme.of(context).primaryColor,
          minimumSize: Size.fromHeight(50),
          shape: ContinuousRectangleBorder(),
        ),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textTheme.button?.color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        onPressed: () => {
          if (!disabled) {onClicked()}
        },
      ),
    );
  }
}
