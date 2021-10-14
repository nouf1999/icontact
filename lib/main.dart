import 'package:flutter/material.dart';

import 'package:icontact/page/contacts_page.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Logo with animated Colorize text
    // ignore: non_constant_identifier_names
    Widget Splash = SplashScreenView(
      navigateRoute: const ContactsPage(),
      duration: 5000,
      imageSize: 150,
      imageSrc: "images/icon.png",
      text: "iContact",
      textType: TextType.ColorizeAnimationText,
      textStyle: const TextStyle(
        fontSize: 40.0,
      ),
      colors: const [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.blue,
    );

    return MaterialApp(
      title: 'iContact',
      home: Splash,
    );
  }
}
