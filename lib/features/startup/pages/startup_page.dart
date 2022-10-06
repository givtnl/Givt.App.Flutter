import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/slide_header1.dart';
import '../widgets/slide_header2.dart';
import '../widgets/slide_header3.dart';
import '../../../core/templates/base_template.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  final ValueNotifier<String> _notifierSVG =
      ValueNotifier('assets/svg/intro_background1.svg');
  final ValueNotifier<int> _notifierCurrentPage = ValueNotifier(0);
  final Color _mainBackgroundColor = Color(0xFFF5F5F5);
  late final _carouselController = CarouselController();
  int _currentPage = 0;
  bool _isExpanded = false;

  List<String> svgImages = [
    'assets/svg/intro_1.svg',
    'assets/svg/intro_2.svg',
    'assets/svg/intro_3.svg'
  ];

  @override
  void initState() {
    super.initState();
    startCarousel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startCarousel() {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      _currentPage++;

      if (_currentPage == 3) {
        timer.cancel();
        setState(() {
          _isExpanded = true;
        });
      } else {
        _carouselController.nextPage();
      }
    });
  }

  void setOvalBackgroundShape(int integer) {
    _notifierCurrentPage.value = integer;
    switch (integer) {
      case 0:
        _notifierSVG.value = 'assets/svg/intro_background1.svg';
        break;
      case 1:
        _notifierSVG.value = 'assets/svg/intro_background2.svg';
        break;
      case 2:
        _notifierSVG.value = 'assets/svg/intro_background3.svg';
        break;
    }
  }

  void animationComplete() {
    if (_isExpanded) {
      print('Animation Complete!!!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: _mainBackgroundColor,
      child: Stack(children: <Widget>[
        ValueListenableBuilder(
          valueListenable: _notifierCurrentPage,
          builder: (BuildContext context, int val, Widget? child) {
            return Center(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  color: (val == 2)
                      ? _isExpanded
                          ? const Color.fromARGB(255, 248, 232, 181)
                          : const Color(0xFFEDC646)
                      : _mainBackgroundColor,
                  padding: const EdgeInsets.only(top: 20),
                  width:
                      _isExpanded ? MediaQuery.of(context).size.height * 1 : 60,
                  height:
                      _isExpanded ? MediaQuery.of(context).size.height * 1 : 60,
                  onEnd: animationComplete,
                ),
              ),
            );
          },
        ),
        Column(
          children: [
            SafeArea(
              child: AnimatedOpacity(
                opacity: _isExpanded ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 500),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: SvgPicture.asset(
                    'assets/svg/logo.svg',
                    height: 25,
                  ),
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 100),
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: double.infinity,
                  child: AnimatedOpacity(
                    opacity: _isExpanded ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: const Center(
                      child: Text(
                        'Welcome to givt',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _isExpanded ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: ValueListenableBuilder(
                      valueListenable: _notifierSVG,
                      builder:
                          (BuildContext context, String svg, Widget? child) {
                        return Container(
                          // color: Colors.yellow,
                          padding: const EdgeInsets.only(top: 330),
                          child: Center(
                              child: SvgPicture.asset(
                            svg,
                          )),
                        );
                      }),
                ),
                AnimatedOpacity(
                  opacity: _isExpanded ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: CarouselSlider(
                      carouselController: _carouselController,
                      options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.8,
                          enableInfiniteScroll: false,
                          viewportFraction: 1,
                          onPageChanged: (integer, _) =>
                              {setOvalBackgroundShape(integer)}),
                      items: svgImages.map((svg) {
                        return ValueListenableBuilder(
                          valueListenable: _notifierCurrentPage,
                          builder:
                              (BuildContext context, int val, Widget? child) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  child: (val == 0)
                                      ? const SlideHeader1()
                                      : (val == 1)
                                          ? const SlideHeader2()
                                          : (val == 2)
                                              ? const SlideHeader3()
                                              : Container(),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(bottom: 40),
                                    child: SvgPicture.asset(svg, width: 320)),
                              ],
                            );
                          },
                        );
                      }).toList()),
                ),
              ],
            ),
          ],
        ),
      ]),
    ));
  }
}
