import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../core/widgets/buttons/button_square_updt.dart';
import '../../core/widgets/navigation/appbar_bottom.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
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
      backgroundColor: Theme.of(context).canvasColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SquareButtonE(
                      title: "Scan Qr Code",
                      iconName: "qr_code",
                      background: Theme.of(context).colorScheme.surface),
                  SquareButtonE(
                      title: "Collection device",
                      iconName: "connection",
                      background: Theme.of(context).primaryColor),
                  SquareButtonE(
                      title: "Find location",
                      iconName: "connection",
                      background: Theme.of(context).primaryColor),
                ],
              ),
            ),
            Text('Home Screen'),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarCustom(),
    );
  }
}
