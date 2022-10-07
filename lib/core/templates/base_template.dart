import 'package:flutter/material.dart';
import '../widgets/buttons/generic_button.dart';
import '../themes/primary_theme.dart';
import './logo_header_template.dart';

class BaseTemplate extends StatelessWidget {
  final Widget pageContent;
  final String title;
  bool hasFooterButton;
  Widget? bypassBtn;
  final VoidCallback? onBtnClick;
  bool? isBtnDisabled;
  double? logoHeight;

  BaseTemplate(
      {required this.pageContent,
      required this.title,
      this.hasFooterButton = true,
      this.isBtnDisabled = false,
      this.onBtnClick,
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
          const LogoHeaderTemplate(),
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
