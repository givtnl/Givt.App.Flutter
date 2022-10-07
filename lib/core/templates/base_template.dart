import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/buttons/generic_button.dart';
import '../themes/primary_theme.dart';

class BaseTemplate extends StatelessWidget {
  final Widget pageContent;
  final String title;
  bool hasFooterButton;
  Widget? bypassBtn;
  final VoidCallback? onBtnClick;
  bool? isBtnDisabled;
  double? logoHeight;
  Color? backgroundColor;

  BaseTemplate(
      {required this.pageContent,
      required this.title,
      this.hasFooterButton = true,
      this.isBtnDisabled = false,
      this.onBtnClick,
      this.bypassBtn,
      this.logoHeight,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    double bottomPadding;
    (bypassBtn != null) ? bottomPadding = 10 : bottomPadding = 35;
    return Scaffold(
      backgroundColor: backgroundColor ?? Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (logoHeight != 0)
              ? SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: SvgPicture.asset(
                      'assets/svg/logo.svg',
                      height: logoHeight ?? 25,
                    ),
                  ),
                )
              : const SizedBox(width: 0, height: 0),
          Container(child: pageContent),
          Container(
            child: hasFooterButton
                ? Padding(
                    padding: EdgeInsets.fromLTRB(35, 0, 35, bottomPadding),
                    child: Column(
                      children: [
                        GenericButton(
                          text: title,
                          disabled: isBtnDisabled!,
                          onClicked: hasFooterButton ? onBtnClick! : () {},
                        ),
                        if (bypassBtn != null) bypassBtn!,
                      ],
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
