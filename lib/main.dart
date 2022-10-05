import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:givt_mobile_apps/core/language/languageIndex.dart';
import 'package:givt_mobile_apps/features/basic_giving_flow/pages/QR_mock_page.dart';
import 'package:provider/provider.dart';
import 'package:givt_mobile_apps/core/constants/routes.dart';
import 'features/benefits/usp.dart';
import 'core/themes/primary_theme.dart';
import 'models/progress.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'providers/camera_permission.dart';
import 'providers/location_permission.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => OnboardingProgressModel()),
      ],
      child: MaterialApp(
        title: 'Givt',
        debugShowCheckedModeBanner: false,
        theme: PrimaryTheme.theme,
        supportedLocales: LangIndex.all,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: const QRmockPage(),
        routes: routes,
      ),
    );
  }
}
