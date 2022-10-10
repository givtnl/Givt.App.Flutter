import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final bool disabled;
  final dynamic primaryColor;
  final dynamic disabledColor;
  final dynamic textColor;

  GenericButton({
    Key? key,
    required this.text,
    required this.disabled,
    required this.onClicked,
    this.primaryColor,
    this.disabledColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor: disabled
              ? (disabledColor != null)
                  ? disabledColor
                  : Theme.of(context).accentColor
              : (primaryColor != null)
                  ? primaryColor
                  : Theme.of(context).primaryColor,
          minimumSize: const Size.fromHeight(50),
          shape: const ContinuousRectangleBorder(),
        ),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: (textColor != null)
                  ? textColor
                  : Theme.of(context).textTheme.button?.color,
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
