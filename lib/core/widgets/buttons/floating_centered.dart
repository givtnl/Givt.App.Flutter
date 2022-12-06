import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FloatingCenteredButton extends StatelessWidget {
  final String asset;
  final VoidCallback clicked;
  FloatingCenteredButton(
      {required this.asset, required this.clicked, super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => {clicked()},
      child: SvgPicture.asset(
        'assets/svg/${asset}.svg',
      ),
    );
  }
}
