import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:givt_mobile_apps/core/language/languageIndex.dart';
import 'package:givt_mobile_apps/utils/locator.dart';
import 'package:givt_mobile_apps/services/navigation_service.dart';
import 'core/themes/primary_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'utils/router.dart' as router;
import 'core/constants/route_paths.dart' as routes;
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setupLocator();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: router.generateRoute,
      initialRoute: routes.StartupRoute,
    );
  }
}
