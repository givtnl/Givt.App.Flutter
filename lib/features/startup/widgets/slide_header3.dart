import 'package:flutter/material.dart';

class SlideHeader3 extends StatelessWidget {
  const SlideHeader3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: <Widget>[
            Center(
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(-2 / 360),
                child: Container(
                  height: 35,
                  width: 280,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 2),
              child: const Center(
                child: Text('Enjoy giving together',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
