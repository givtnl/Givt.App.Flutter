import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';

import 'package:givt_mobile_apps/core/templates/logo_header_template.dart';
import 'package:givt_mobile_apps/features/startup/widgets/slide_header1.dart';
import 'package:givt_mobile_apps/features/startup/widgets/slide_header2.dart';
import 'package:givt_mobile_apps/features/startup/widgets/slide_header3.dart';
import 'package:givt_mobile_apps/features/startup/widgets/intro_page_progress_bar.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'package:givt_mobile_apps/core/constants/route_paths.dart' as routes;

class StartupPage extends StatefulWidget {
  const StartupPage({Key? key}) : super(key: key);

  @override
  State<StartupPage> createState() => _StartupPageState();
}

enum IntroPages {
  intro_1(
      backgroundSvgPath: "assets/svg/intro_background1.svg",
      svgPath: "assets/svg/intro_1.svg"),
  intro_2(
      backgroundSvgPath: "assets/svg/intro_background2.svg",
      svgPath: "assets/svg/intro_2.svg"),
  intro_3(
      backgroundSvgPath: "assets/svg/intro_background3.svg",
      svgPath: "assets/svg/intro_3.svg"),
  ;

  const IntroPages({
    required this.backgroundSvgPath,
    required this.svgPath,
  });

  final String backgroundSvgPath;
  final String svgPath;
}

class _StartupPageState extends State<StartupPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  final LocalStorageProxy _storageProxy = locator<LocalStorageProxy>();
  final Color _mainBackgroundColor = const Color(0xFFF5F5F5);
  late final _carouselController = CarouselController();

  final Duration _introPageAnimationDuration =
      const Duration(milliseconds: 3000);
  final Duration _outroAnimationDuration = const Duration(milliseconds: 500);

  bool _isCarouselStarted = false;
  bool _isCarouselFinished = false;
  int _currentPage = 0;

  bool get isLastPage {
    return _currentPage == IntroPages.values.length - 1;
  }

  @override
  void initState() {
    super.initState();
    _storageProxy.setWelcomeFlag(true);
    _initialization();
    Future.delayed(Duration.zero, () {
      _startCarousel();
    });
  }

  void _initialization() async {
    FlutterNativeSplash.remove();
  }

  void _startCarousel() {
    setState(() {
      _isCarouselStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AbsorbPointer(
        absorbing: true,
        child: Container(
          color: _mainBackgroundColor,
          child: Stack(
            children: [
              if (isLastPage) _buildCircleExpansion(),
              _buildOutroTransition(),
              AnimatedOpacity(
                opacity: _isCarouselFinished ? 0.0 : 1.0,
                duration: _outroAnimationDuration,
                child: Column(
                  children: [
                    const SafeArea(child: LogoHeaderTemplate()),
                    _buildCarousel(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleExpansion() {
    return Padding(
      padding: const EdgeInsets.only(top: 165),
      child: Center(
        child: AnimatedScale(
          duration: _outroAnimationDuration,
          curve: Curves.easeOut,
          scale: _isCarouselFinished ? 4 : 1,
          child: SvgPicture.asset(
            IntroPages.values.last.backgroundSvgPath,
          ),
        ),
      ),
    );
  }

  Widget _buildOutroTransition() {
    return AnimatedOpacity(
      opacity: _isCarouselFinished ? 1.0 : 0.0,
      curve: Curves.easeOut,
      duration: _outroAnimationDuration,
      onEnd: onOutroAnimationEnd,
      child: Center(
        child: SvgPicture.asset(
          'assets/svg/logo_white.svg',
          height: 70,
        ),
      ),
    );
  }

  void onOutroAnimationEnd() {
    if (_isCarouselFinished) {
      Future.delayed(const Duration(seconds: 2), () {
        _navigationService.navigateTo(routes.LocationPermissionRoute);
      });
    }
  }

  Widget _buildCarousel() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Stack(
        children: [
          _buildBackgroundBlob(),
          Column(
            children: [
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.7,
                    enableInfiniteScroll: false,
                    autoPlay: _isCarouselStarted &&
                        _currentPage < IntroPages.values.length - 1,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 300),
                    autoPlayInterval: _introPageAnimationDuration,
                    viewportFraction: 1,
                    onPageChanged: (currentPage, _) {
                      if (currentPage == IntroPages.values.length - 1) {
                        Future.delayed(_introPageAnimationDuration, () {
                          setState(() {
                            _isCarouselFinished = true;
                          });
                        });
                      }
                      setState(() {
                        _currentPage = currentPage;
                      });
                    }),
                items: IntroPages.values.map((introPage) {
                  final Widget header;
                  switch (introPage) {
                    case IntroPages.intro_1:
                      header = const SlideHeader1();
                      break;
                    case IntroPages.intro_2:
                      header = const SlideHeader2();
                      break;
                    case IntroPages.intro_3:
                      header = const SlideHeader3();
                      break;
                    default:
                      header = Container();
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      header,
                      SvgPicture.asset(introPage.svgPath, width: 320),
                    ],
                  );
                }).toList(),
              ),
              _buildSliderProgressBars(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSliderProgressBars() {
    return Container(
      padding: const EdgeInsets.fromLTRB(80, 50, 80, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: IntroPages.values.map((introPage) {
          return IntroPageProgressBar(
            color: Theme.of(context).colorScheme.secondary,
            duration: _introPageAnimationDuration,
            isFilled: _isCarouselStarted && _currentPage >= introPage.index,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBackgroundBlob() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: SvgPicture.asset(
              IntroPages.values[_currentPage].backgroundSvgPath,
            ),
          ),
        ],
      ),
    );
  }
}
