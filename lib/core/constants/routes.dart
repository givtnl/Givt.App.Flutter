import 'package:flutter/material.dart';

import '../../features/benefits/usp.dart';
import '../../features/permissions/pages/camera_permission_page.dart';
import '../../features/permissions/pages/location_permission_page.dart';

Map<String, WidgetBuilder> routes = {
  '/usp': (context) => const UspPage(),
  '/camera-permission': (context) => const CameraPermissionPage(),
  '/location-permission': (context) => const LocationPermissionPage(),
};
