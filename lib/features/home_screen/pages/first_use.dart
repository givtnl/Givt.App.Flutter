import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:givt_mobile_apps/core/templates/logo_header_template.dart';
import '../../../core/widgets/buttons/button_square_updt.dart';
import '../../../core/widgets/navigation/appbar_bottom.dart';

class FirstUsePage extends StatefulWidget {
  const FirstUsePage({super.key});

  @override
  State<FirstUsePage> createState() => _FirstUsePageState();
}

class _FirstUsePageState extends State<FirstUsePage> {
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
      backgroundColor: Theme.of(context).backgroundColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              LogoHeaderTemplate(),
              SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 30 * 2,
                    child: Text(
                      'Welcome, ',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  Text('Choose to start using Givt!'),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('I want to donate now'),
              ),
              Text(' ---------- or ---------- '),
              ElevatedButton(
                onPressed: () {},
                child: Text('I want to select my favorite organization(s)'),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBarCustom(),
    );
  }
}
