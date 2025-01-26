import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class SimpleJoystickGame extends FlameGame with HasCollisionDetection {
  late final JoystickPlayer player;
  late final JoystickComponent joystick;
  late final TextComponent speedText;

  @override
  Future<void> onLoad() async {
    final image = await images.load('joystick.png');
    final sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 6,
      rows: 1,
    );

    // Crear el joystick
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: sheet.getSpriteById(1),
        size: Vector2.all(100),
      ),
      background: SpriteComponent(
        sprite: sheet.getSpriteById(0),
        size: Vector2.all(150),
      ),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    // Crear el jugador controlado por el joystick
    player = JoystickPlayer(joystick);

    // Mostrar la velocidad
    final regular = TextPaint(
      style: TextStyle(color: Colors.white),
    );
    speedText = TextComponent(
      text: 'Speed: 0',
      textRenderer: regular,
    )..position = Vector2(10, 10);

    add(player);
    add(joystick);
    add(speedText);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Actualizar el texto de la velocidad
    speedText.text = 'Speed: ${(joystick.intensity * player.maxSpeed).round()}';
  }
}

class JoystickPlayer extends SpriteComponent with HasGameRef {
  JoystickPlayer(this.joystick)
      : super(
          size: Vector2.all(50),
          anchor: Anchor.center,
        );

  final JoystickComponent joystick;
  final double maxSpeed = 200.0;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('character1.png');
    position = gameRef.size / 2;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Mover al jugador basado en la dirección del joystick
    if (joystick.delta != Vector2.zero()) {
      position += joystick.relativeDelta * maxSpeed * dt;
    }
  }
}
