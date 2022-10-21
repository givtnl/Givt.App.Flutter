import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
import 'package:givt_mobile_apps/utils/progress_indicator.dart';
// ignore: import_of_legacy_library_into_null_safe
import '../../../core/templates/logo_header_template.dart';
import '../../../core/constants/route_paths.dart' as routes;
import '../widgets/slide_header1.dart';
import '../widgets/slide_header2.dart';
import '../widgets/slide_header3.dart';
import '../../../services/navigation_service.dart';
import '../../../utils/locator.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  final ValueNotifier<String> _notifierSVG =
      ValueNotifier('assets/svg/intro_background1.svg');
  final ValueNotifier<int> _notifierCurrentPage = ValueNotifier(0);
  final Color _mainBackgroundColor = const Color(0xFFF5F5F5);
  final Duration _slideDuration = const Duration(seconds: 3);
  late final _carouselController = CarouselController();
  final _storyProgressKey = GlobalKey<ProgressIndicatorState>();
  final LocalStorageProxy _model = locator<LocalStorageProxy>();
  int _currentPage = 0;
  bool _isExpanded = false;

  List<String> svgImages = [
    'assets/svg/intro_1.svg',
    'assets/svg/intro_2.svg',
    'assets/svg/intro_3.svg'
  ];

  @override
  void initState() {
    _model.downgradeProgress('camera');
    _model.downgradeProgress('location');
    var current = _model.realm.all<LocalStorage>().first;
    print(
        'Progress camera is ${current.cameraAsked}; and location is  ${current.locationAsked}');
    super.initState();
    initialization();
    Future.delayed(Duration.zero, () {
      startCarousel();
    });
  }
  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startCarousel() {
    if (_storyProgressKey.currentState?.isPlaying() == false) {
      _storyProgressKey.currentState?.resume();
    }

    Timer.periodic(_slideDuration, (timer) {
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
      Timer(const Duration(seconds: 2), () {
        _navigationService.navigateTo(routes.LocationPermissionRoute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: _mainBackgroundColor,
      child: Stack(children: <Widget>[
        _buildCircleExpansion(),
        Column(
          children: [
            SafeArea(
              child: AnimatedOpacity(
                  opacity: _isExpanded ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 350),
                  child: const LogoHeaderTemplate()),
            ),
            Stack(
              children: <Widget>[
                _buildWelcomeTransition(),
                _buildBackgroundBlob(),
                _buildCarousel()
              ],
            ),
          ],
        ),
      ]),
    ));
  }

  Widget _buildCircleExpansion() {
    return ValueListenableBuilder(
      valueListenable: _notifierCurrentPage,
      builder: (BuildContext context, int val, Widget? child) {
        return Center(
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: (_isExpanded)
                    ? const BorderRadius.all(Radius.circular(0))
                    : const BorderRadius.all(Radius.circular(50)),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  color: (val == 2)
                      ? _isExpanded
                          ? Theme.of(context).colorScheme.surface
                          : const Color(0xFFEDC646)
                      : _mainBackgroundColor,
                  width:
                      _isExpanded ? MediaQuery.of(context).size.height * 1 : 60,
                  height:
                      _isExpanded ? MediaQuery.of(context).size.height * 1 : 60,
                  onEnd: animationComplete,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWelcomeTransition() {
    return Container(
      padding: const EdgeInsets.only(bottom: 100),
      height: (MediaQuery.of(context).size.height * 0.9) -
          MediaQuery.of(context).padding.top,
      width: double.infinity,
      child: AnimatedOpacity(
        opacity: _isExpanded ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Center(
          child: SvgPicture.asset(
            'assets/svg/logo_white.svg',
            height: 100,
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundBlob() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: AnimatedOpacity(
        opacity: _isExpanded ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 500),
        child: ValueListenableBuilder(
            valueListenable: _notifierSVG,
            builder: (BuildContext context, String svg, Widget? child) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                        child: SvgPicture.asset(
                      svg,
                    )),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _buildCarousel() {
    return AnimatedOpacity(
      opacity: _isExpanded ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.7,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  onPageChanged: (integer, _) =>
                      {setOvalBackgroundShape(integer)}),
              items: svgImages.map((svg) {
                return ValueListenableBuilder(
                  valueListenable: _notifierCurrentPage,
                  builder: (BuildContext context, int val, Widget? child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: (val == 0)
                              ? const SlideHeader1()
                              : (val == 1)
                                  ? const SlideHeader2()
                                  : (val == 2)
                                      ? SlideHeader3()
                                      : Container(),
                        ),
                        Container(
                            // color: Colors.red,
                            //margin: const EdgeInsets.only(bottom: 0),
                            child: SvgPicture.asset(svg, width: 320)),
                      ],
                    );
                  },
                );
              }).toList(),
            ),
            _buildSliderProgressBars()
          ],
        ),
      ),
    );
  }

  Widget _buildSliderProgressBars() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
      child: ProgressIndicator(
        color: Theme.of(context).colorScheme.secondary,
        key: _storyProgressKey,
        progressCount: 3,
        duration: _slideDuration,
        onStatusChanged: (_) {},
      ),
    );
  }
}
