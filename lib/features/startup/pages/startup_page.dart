import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/templates/base_template.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<Color> _notifier =
        ValueNotifier(Color(0xff7DBDA2).withOpacity(0.5));
    Color carouselBackgroundColor = Color(0xff7DBDA2).withOpacity(0.5);

    void setOvalBackgroundShape(int) {
      switch (int) {
        case 0:
          _notifier.value = Color(0xff7DBDA2).withOpacity(0.5);
          break;
        case 1:
          _notifier.value = Color(0xff95b0dd).withOpacity(0.5);
          break;
        case 2:
          _notifier.value = Color(0xffefc0a6).withOpacity(0.5);
          break;
      }
    }

    List<String> svgImages = [
      'assets/svg/intro_1.svg',
      'assets/svg/intro_2.svg',
      'assets/svg/intro_3.svg'
    ];
    return BaseTemplate(
        title: 'welcome screen',
        hasFooterButton: false,
        pageContent: Column(
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
                  padding: EdgeInsets.only(top: 2),
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
            SizedBox(
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
                  padding: EdgeInsets.only(top: 2),
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
            Container(
              height: 400,
              // color: Colors.red,
              width: double.infinity,
              child: Center(
                child: Stack(
                  children: <Widget>[
                    ValueListenableBuilder(
                        valueListenable: _notifier,
                        builder:
                            (BuildContext context, Color val, Widget? child) {
                          return Positioned(
                            top: 39,
                            right: 45,
                            child: CustomPaint(
                              size: Size(
                                  300, (300 * 1.0031948881789137).toDouble()),
                              painter: RPSCustomPainter(val),
                            ),
                          );
                        }),
                    CarouselSlider(
                        options: CarouselOptions(
                          height: 400.0,
                          autoPlay: true,
                          viewportFraction: 1,
                          onPageChanged: (int, _) =>
                              setOvalBackgroundShape(int),
                        ),
                        items: svgImages.map((svg) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  child: SvgPicture.asset(svg, width: 300));
                            },
                          );
                        }).toList())
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class RPSCustomPainter extends CustomPainter {
  Color color;
  RPSCustomPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9568275, size.height * 0.6771879);
    path_0.cubicTo(
        size.width * 0.8556454,
        size.height * 0.9129204,
        size.width * 0.5885847,
        size.height * 1.014162,
        size.width * 0.3793514,
        size.height * 0.9969013);
    path_0.cubicTo(
        size.width * 0.3222268,
        size.height * 0.9921879,
        size.width * 0.2072757,
        size.height * 0.9826975,
        size.width * 0.1174994,
        size.height * 0.8980796);
    path_0.cubicTo(
        size.width * -0.05486486,
        size.height * 0.7356274,
        size.width * -0.02831521,
        size.height * 0.3959777,
        size.width * 0.1366687,
        size.height * 0.1960099);
    path_0.cubicTo(
        size.width * 0.1579147,
        size.height * 0.1702774,
        size.width * 0.3050073,
        size.height * -0.002270347,
        size.width * 0.5342077,
        size.height * 0.00002264557);
    path_0.cubicTo(
        size.width * 0.7020351,
        size.height * 0.001710545,
        size.width * 0.8197987,
        size.height * 0.09620096,
        size.width * 0.8341438,
        size.height * 0.1079844);
    path_0.cubicTo(
        size.width * 0.8522268,
        size.height * 0.1228570,
        size.width * 0.8921310,
        size.height * 0.1582073,
        size.width * 0.9281054,
        size.height * 0.2142583);
    path_0.cubicTo(
        size.width * 1.012610,
        size.height * 0.3459777,
        size.width * 1.020054,
        size.height * 0.5298949,
        size.width * 0.9568275,
        size.height * 0.6771879);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color;
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
