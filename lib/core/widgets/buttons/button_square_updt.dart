import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SquareButtonE extends StatelessWidget {
  final String title;
  final String iconName;
  final Color background;
  const SquareButtonE(
      {super.key,
      required this.title,
      required this.iconName,
      required this.background});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: background,
        child: ClipRRect(
          //this doesnt do shit haha. gotta clip out the inkwell somehow else
          borderRadius: BorderRadius.circular(40.0),
          child: InkWell(
            onTap: () {
              //To be done
            },
            child: SizedBox(
              width: 100,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svg/${iconName}.svg'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
