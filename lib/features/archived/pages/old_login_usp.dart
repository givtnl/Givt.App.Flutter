import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/templates/logo_header_template.dart';
import '../../../core/widgets/buttons/generic_button.dart';

class LoginUspPage extends StatefulWidget {
  const LoginUspPage({super.key});

  @override
  State<LoginUspPage> createState() => _LoginUspPageState();
}

class _LoginUspPageState extends State<LoginUspPage> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const LogoHeaderTemplate(),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Center(
                  child: Stack(children: <Widget>[
                    SvgPicture.asset(
                      'assets/svg/intro_background1.svg',
                      height: 140,
                    ),
                    SvgPicture.asset(
                      'assets/svg/intro_1.svg',
                      height: 140,
                    ),
                  ]),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      softWrap: false,
                      'Give instantly',
                      style: TextStyle(
                        overflow: TextOverflow.visible,
                        color: Theme.of(context).textTheme.bodyText1?.color,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'even when offline',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1?.color,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  textAlign: TextAlign.right,
                  'Receive one tax statement',
                  style: TextStyle(
                    overflow: TextOverflow.visible,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                //color: Colors.green,
                child: Center(
                  child: Stack(children: <Widget>[
                    SvgPicture.asset(
                      'assets/svg/intro_background2.svg',
                      height: 140,
                    ),
                    SvgPicture.asset(
                      'assets/svg/intro_2.svg',
                      height: 140,
                    ),
                  ]),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                //color: Colors.green,
                child: Center(
                  child: Stack(children: <Widget>[
                    SvgPicture.asset(
                      'assets/svg/intro_background3.svg',
                      height: 140,
                    ),
                    SvgPicture.asset(
                      'assets/svg/intro_3.svg',
                      height: 140,
                    ),
                  ]),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  textAlign: TextAlign.left,
                  'Enjoy giving together',
                  style: TextStyle(
                    overflow: TextOverflow.visible,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          GenericButton(
            text: 'Give now',
            disabled: false,
            onClicked: () {},
          ),
          const SizedBox(
            height: 15,
          ),
          GenericButton(
            text: 'Login',
            primaryColor: const Color.fromARGB(255, 24, 72, 105),
            disabled: false,
            onClicked: () {},
          ),
        ]),
      ),
    );
  }
}
