import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:parental_control/firebase_options.dart';
import 'package:parental_control/i18n/Messages.dart';
import 'package:parental_control/services/app_usage_service.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/services/geo_locator_service.dart';
import 'package:parental_control/theme/theme.dart';
import 'package:provider/provider.dart';

import 'app/config/screencontroller_config.dart';

//TODO: ADD easyLocalization to translate app
//TODO: Write all strings in a Class
//TODO: Add contactUs page
//TODO: Share UNIQUE CODE

main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    Provider<AuthBase>(create: (context) => Auth()),
    Provider<AppUsageService>(create: (context) => AppUsageService()),
    Provider<GeoLocatorService>(create: (context) => GeoLocatorService()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final geoService = Provider.of<GeoLocatorService>(context, listen: false);
    final apps = Provider.of<AppUsageService>(context);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farzand Nazorati',
      translations: Messages(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.DarkTheme,
      locale: Messages.defaultLang,
      themeMode: ThemeMode.light,
      home: FutureBuilder(
          future: Future.wait([
            geoService.getInitialLocation().whenComplete(() => print('DEBUG: GEO SERVICE SUCCESSFULLY LOADED')),
            apps.getAppUsageService().whenComplete(() => print('DEBUG: APP SERVICE SUCCESSFULLY LOADED')),
          ]),
          builder: (context, _) => ScreensController()),
    );
  }
}
