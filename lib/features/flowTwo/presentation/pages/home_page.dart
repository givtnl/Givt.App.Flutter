import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/constants/palette.dart';
import 'package:givt_mobile_apps/features/flowTwo/presentation/components/square_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Palette.background,
        elevation: 0,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Image(image: AssetImage('assets/images/logo.png')),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SquareButton(
              title: "scan Qr code",
              icon: Icon(Icons.qr_code_rounded,
                  size: 60, color: Palette.background),
              background: Palette.darkBlue,
            ),
            SquareButton(
              title: "collection device nearby",
              icon: Icon(Icons.sensors_rounded,
                  size: 60, color: Palette.background),
              background: Palette.deepPurple,
            ),
          ],
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        color: Palette.white,
        elevation: 1,
        child: const Text('Hello'),
      ),
    );
  }
}
