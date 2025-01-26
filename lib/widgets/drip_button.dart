import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class DripButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final String riveAssetPath;
  final double? width;
  final double? height;

  const DripButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.riveAssetPath,
    this.color = const Color(0xFF4CAF50),
    this.textColor = Colors.white,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _DripButtonState createState() => _DripButtonState();
}

class _DripButtonState extends State<DripButton> {
  late RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('Idle');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: widget.width,
              height: widget.height,
              child: RiveAnimation.asset(
                widget.riveAssetPath,
                fit: BoxFit.cover,
                controllers: [_controller],
              ),
            ),
            Positioned(
              top: 20,
              child: Text(
                widget.text,
                style: TextStyle(
                    color: widget.textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
