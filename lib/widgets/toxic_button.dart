import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGButton extends StatelessWidget {
  final String svgPath;
  final VoidCallback onPressed;
  final double size;

  const SVGButton({
    Key? key,
    required this.svgPath,
    required this.onPressed,
    this.size = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        svgPath,
        width: size,
        height: size,
      ),
      onPressed: onPressed,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SVG Button Example'),
      ),
      body: Center(
        child: SVGButton(
          svgPath: 'assets/my_icon.svg',
          onPressed: () {
            print('SVG Button pressed!');
          },
          size: 48.0,
        ),
      ),
    );
  }
}

// Main function to run the app
void main() {
  runApp(MaterialApp(home: MyHomePage()));
}
