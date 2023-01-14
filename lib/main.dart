import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notes app',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      // darkTheme: ThemeData.dark(useMaterial3: true),
      defaultTransition: Transition.fadeIn,
      enableLog: false,
      home: const SplashScreen(),
    );
  }
}
