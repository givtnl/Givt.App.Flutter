import 'package:flutter/material.dart';

class IntroPageProgressBar extends StatelessWidget {
  const IntroPageProgressBar({
    Key? key,
    this.isFilled = false,
    this.color = Colors.blueGrey,
    this.duration = const Duration(milliseconds: 3000),
  }) : super(key: key);

  final bool isFilled;
  final Color color;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Container(
          color: color.withOpacity(0.3),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return AnimatedContainer(
                      duration: duration,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                      ),
                      width: isFilled ? constraints.maxWidth : 0,
                      height: 4,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
