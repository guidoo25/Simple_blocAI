import 'package:cloudinary_midu/screens/gamecomponents/character.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GameScene extends Component with HasGameRef {
  final List<String> prompts;

  GameScene({required this.prompts});

  @override
  Future<void> onLoad() async {
    for (var i = 0; i < prompts.length; i++) {
      final card = CardComponent(
        prompt: prompts[i],
        position: Vector2(100 * i + 50, 200), // Posiciones de las cartas
      );

      add(card);
    }
  }
}
