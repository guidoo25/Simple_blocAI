import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class CardComponent extends PositionComponent with HasGameRef {
  final String prompt;

  // Añadimos variables para la animación
  double _scale = 1.0;
  bool _isHovered = false;
  late Sprite sprite;

  CardComponent({
    required this.prompt,
    required Vector2 position,
  }) : super(position: position, size: Vector2(100, 150));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final cardImage = await gameRef.images.load('example_card.jpg');
    sprite = Sprite(cardImage);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Efecto de levante
    if (_isHovered) {
      _scale = (_scale + 0.1 * dt).clamp(1.0, 1.2); // Escala hasta 1.2
    } else {
      _scale = (_scale - 0.1 * dt).clamp(1.0, 1.0); // Regresa a 1.0
    }

    scale = Vector2.all(_scale);
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.scale(_scale, _scale);
    super.render(canvas);
    canvas.restore();
  }

  void onHoverEnter() {
    _isHovered = true;
  }

  void onHoverExit() {
    _isHovered = false;
  }
}
