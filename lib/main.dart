import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'
    hide LocalStorage;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:givt_mobile_apps/core/language/languageIndex.dart';
import 'package:givt_mobile_apps/models/localStorage.dart';
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  late final LocalStorageProxy realmProxy = locator<LocalStorageProxy>();

  @override
  Widget build(BuildContext context) {
    final LocalStorage current = realmProxy.realm.all<LocalStorage>().first;

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
      initialRoute: (current.locationAsked)
          ? routes.FirstUseScreenRoute
          : routes.StartupRoute,
    );
  }
}
