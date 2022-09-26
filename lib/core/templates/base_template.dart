import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/buttons/generic_button.dart';
import '../constants/theme.dart';

class BaseTemplate extends StatelessWidget {
  final Widget pageContent;
  final Function onBtnClick;
  bool isBtnDisabled;

  BaseTemplate(
      {required this.pageContent,
      required this.onBtnClick,
      required this.isBtnDisabled});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.theme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: SvgPicture.asset(
                'assets/svg/logo.svg',
                height: AppTheme.theme.logoSize,
              ),
            ),
          ),
          Container(child: pageContent),
          Padding(
            padding: EdgeInsets.fromLTRB(35, 0, 35, 35),
            child: GenericButton(
              text: 'Continue',
              disabled: isBtnDisabled,
              onClicked: () {
                onBtnClick();
              },
            ),
          )
        ],
      ),
    );
  }
}
