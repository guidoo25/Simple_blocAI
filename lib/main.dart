import 'package:cloudinary_midu/screens/gamecomponents/joystic.dart';
import 'package:cloudinary_midu/screens/gamecomponents/scena.dart';
import 'package:cloudinary_midu/screens/index.dart';
import 'package:cloudinary_midu/screens/menu/menu.dart';
import 'package:cloudinary_midu/screens/onboard.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ThickFrame(
        child: ImageSwiperScreen(),
        // child: GameWidget(
        //   game: GameScene(),
        // ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
