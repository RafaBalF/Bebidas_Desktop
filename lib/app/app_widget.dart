import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'My Smart App',
      theme: ThemeData(primarySwatch: Colors.amber),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    ); //added by extensionflut
  }
}

// ignore_for_file: prefer_const_constructors

List<SideMenuItem> items = [
  SideMenuItem(
    priority: 0,
    title: 'Pedidos',
    onTap: () => {},
    icon: Icon(Icons.shopping_cart),
  ),
];
