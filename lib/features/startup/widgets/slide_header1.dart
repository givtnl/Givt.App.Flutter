import 'package:flutter/material.dart';

class SlideHeader1 extends StatelessWidget {
  const SlideHeader1({super.key});

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
                  height: 46,
                  width: 230,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 2, left: 5),
              child: const Center(
                child: Text("Give instantly",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    )),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Stack(
          children: <Widget>[
            Center(
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(2 / 360),
                child: Container(
                  height: 26,
                  width: 145,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 2, left: 5),
              child: const Center(
                child: Text("even when offline",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
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
