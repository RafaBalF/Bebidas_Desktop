import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:window_manager/window_manager.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    title: 'Bebidas Online',
    fullScreen: false,
    // //size: Size(800, 800),
    // //minimumSize: Size(WindowManager.instance.setMaximumSize((1000,1000))),
    // center: true,
    // backgroundColor: Colors.white,
    // skipTaskbar: true,
    // titleBarStyle: TitleBarStyle.normal,
    // alwaysOnTop: true,
  );
  // windowManager.waitUntilReadyToShow(windowOptions, () async {
  //   //await windowManager.show();
  //   //await windowManager.focus();
  //   await windowManager.setMovable(false);
  //   await windowManager.maximize();
  //   await windowManager.setMaximizable(false);
  // });

  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
