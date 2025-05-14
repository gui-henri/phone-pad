import 'package:controller_emulator_client/pages/configuration_page.dart';
import 'package:controller_emulator_client/pages/connection_page.dart';
import 'package:controller_emulator_client/pages/controller_page.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(dynamic)> instanceRoutes(BuildContext context) => {
      ConnectionPage.routeName: (context) => const ConnectionPage(),
      ControllerPage.routeName: (context) => const ControllerPage(),
      ConfigurationPage.routeName: (context) => const ConfigurationPage()
    };
