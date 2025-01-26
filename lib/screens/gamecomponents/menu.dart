import 'package:cloudinary_midu/screens/gamecomponents/scena.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class MenuScene extends Component with HasGameRef {
  late TextEditingController _promptController1;
  late TextEditingController _promptController2;
  late TextEditingController _promptController3;

  @override
  Future<void> onLoad() async {
    _promptController1 = TextEditingController();
    _promptController2 = TextEditingController();
    _promptController3 = TextEditingController();
  }

  @override
  void render(Canvas canvas) {
    //dibujemos menu mevieval
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, gameRef.size.x, gameRef.size.y);
    canvas.drawRect(rect, paint);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    // Aquí podrías hacer que los botones del menú respondan al toque
    // Por ejemplo, tras escribir los prompts, ir a la pantalla del juego:
    if (_promptController1.text.isNotEmpty &&
        _promptController2.text.isNotEmpty &&
        _promptController3.text.isNotEmpty) {
      gameRef.add(GameScene(
        prompts: [
          _promptController1.text,
          _promptController2.text,
          _promptController3.text,
        ],
      ));
    }
    return false;
  }
}
