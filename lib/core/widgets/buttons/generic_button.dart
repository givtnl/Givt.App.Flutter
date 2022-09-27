import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';
import '../../theme/theme.dart';

class GenericButton extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final bool disabled;
  String? where;

  const GenericButton({
    Key? key,
    required this.text,
    required this.disabled,
    required this.onClicked,
    this.where,
  }) : super(key: key);

  void navigate(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => where),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
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
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      onPressed: () => {
        if (!disabled) {onClicked()}
      },
    );
  }
}
