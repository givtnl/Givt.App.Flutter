import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OptionsButton extends StatelessWidget {
  final VoidCallback clicked;
  final Color color;
  final String title;
  final String subtitle;
  final String asset;
  const OptionsButton(
      {required this.title,
      required this.subtitle,
      required this.clicked,
      required this.color,
      required this.asset,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: ElevatedButton(
        onPressed: () => {clicked()},
        style: ElevatedButton.styleFrom(
          elevation: 7.0,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 45 * 2,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/${asset}.svg',
                  height: (asset.contains('connection') == true) ? 30 : 50,
                ),
                SizedBox(width: 20),
                SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
