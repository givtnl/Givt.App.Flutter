import 'package:flutter/material.dart';

class SlideHeader2 extends StatelessWidget {
  const SlideHeader2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Stack(
          children: <Widget>[
            Center(
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(-2 / 360),
                child: Container(
                  height: 40,
                  width: 240,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 2, left: 5),
              child: const Center(
                child: Text("Receive one tax",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    )),
              ),
            ),
          ],
        ),
        Stack(
          children: <Widget>[
            Center(
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(3 / 360),
                child: Container(
                  height: 35,
                  width: 145,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: const Center(
                child: Text("statement",
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
