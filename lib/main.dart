import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
import './ui/HomePage.dart';
import 'service/ThemeService.dart';
import 'ui/Themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Application name
      title: 'Flutter Stateful Clicker Counter',
      theme: Themes.light,
      themeMode: ThemeService().theme,
      darkTheme: Themes.dark,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
