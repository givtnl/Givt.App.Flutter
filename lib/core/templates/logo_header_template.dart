import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoHeaderTemplate extends StatelessWidget {
  final double logoHeight;
  const LogoHeaderTemplate({this.logoHeight = 25});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: SvgPicture.asset(
          'assets/svg/logo.svg',
          height: logoHeight,
        ),
      ),
    );
  }
}
