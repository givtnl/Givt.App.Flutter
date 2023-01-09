import 'package:flutter/material.dart';
import 'package:givt_mobile_apps/core/templates/logo_header_template.dart';
import 'package:givt_mobile_apps/core/widgets/notifications/no_connection_bar.dart';
import 'package:givt_mobile_apps/services/check_internet_connectivity.dart';
import 'package:provider/provider.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Consumer<ConnectivityService>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                child!,
                (!provider.hasInternet)
                    ? const noConnectionBar()
                    : const SizedBox(),
              ],
            );
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const LogoHeaderTemplate(),
                  const SizedBox(height: 25),
                  Text(
                    'Thank you for your generous generousity!',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.surface),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          )),
    );
  }
}
