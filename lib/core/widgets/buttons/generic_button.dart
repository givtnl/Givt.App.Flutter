import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';
import '../../constants/theme.dart';

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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            disabled ? AppTheme.theme.btnInactive : AppTheme.theme.btnActive,
        minimumSize: Size.fromHeight(50),
        shape: ContinuousRectangleBorder(),
      ),
      child: FittedBox(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: AppTheme.theme.btnText,
          ),
        ),
      ),
      onPressed: () => {
        if (!disabled) {onClicked()}
      },
    );
  }
}
