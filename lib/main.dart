import 'package:flutter/material.dart';
import 'package:icontact/home.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Normal Logo Splash screen
    Widget example1 = SplashScreenView(
      navigateRoute: const Homepage(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "icon.png",
      backgroundColor: Colors.white,
    );
/* 
    /// Logo with animated Colorize text
    Widget example2 = SplashScreenView(
      navigateRoute: SecondScreen(),
      duration: 5000,
      imageSize: 130,
      imageSrc: "splashscreen_image.png",
      text: "Splash Screen",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 40.0,
      ),
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );

    /// Logo with Typer Animated Text example
    Widget example3 = SplashScreenView(
      navigateRoute: SecondScreen(),
      duration: 3000,
      imageSize: 130,
      pageRouteTransition: PageRouteTransition.Normal,
      imageSrc: "splashscreen_image.png",
      speed: 100,
      text: "Splash Screen",
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: Colors.white,
    );

    /// Logo with Scale Animated Text example
    Widget example4 = SplashScreenView(
      navigateRoute: SecondScreen(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "splashscreen_image.png",
      text: "Splash Screen",
      textType: TextType.ScaleAnimatedText,
      textStyle: TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: Colors.white,
    );

    /// Logo with Normal Text example
    Widget example5 = SplashScreenView(
      navigateRoute: SecondScreen(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "splashscreen_image.png",
      text: "Splash Screen",
      textType: TextType.NormalText,
      textStyle: TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: Colors.white,
    );
 */
    return MaterialApp(
      title: 'Splash screen Demo',
      home: example1,
    );
  }
}
