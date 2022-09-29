import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/buttons/generic_button.dart';
import '../themes/primary_theme.dart';

class BaseTemplate extends StatelessWidget {
  final Widget pageContent;
  final Function onBtnClick;
  final String title;
  Widget? bypassBtn;
  bool isBtnDisabled;
  double? logoHeight;

  BaseTemplate(
      {required this.pageContent,
      required this.onBtnClick,
      required this.title,
      required this.isBtnDisabled,
      this.bypassBtn,
      this.logoHeight});

  @override
  Widget build(BuildContext context) {
    double bottomPadding;
    (bypassBtn != null) ? bottomPadding = 10 : bottomPadding = 35;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: SvgPicture.asset(
                'assets/svg/logo.svg',
                height: logoHeight ?? 25,
              ),
            ),
          ),
          Container(child: pageContent),
          Padding(
            padding: EdgeInsets.fromLTRB(35, 0, 35, bottomPadding),
            child: Column(
              children: [
                GenericButton(
                  text: title,
                  disabled: isBtnDisabled,
                  onClicked: () {
                    onBtnClick();
                  },
                ),
                if (bypassBtn != null) bypassBtn!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
