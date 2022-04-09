import 'package:flutter/material.dart';
import '/views/home.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          splash: Icons.newspaper_sharp,
          duration: 3000,
          splashTransition: SplashTransition.scaleTransition,
          /* backgroundColor: Colors.blueGrey, */
          nextScreen: Home()),
    );
  }
}
