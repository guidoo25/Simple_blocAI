// import 'package:flame/game.dart';
// import 'package:flame/components.dart';
// import 'package:flame/input.dart';
// import 'package:flame_rive/flame_rive.dart';
// import 'package:flutter/material.dart';

// class MyGame extends FlameGame with TapDetector, KeyboardEvents {
//   late RiveComponen fog;
//   late SpriteComponent player;
//   late TextComponent terminal;
//   late SpriteComponent background;
//   List<String> terminalLines = [
//     "Welcome to the terminal!",
//     "Selecciona tu personaje"
//   ];

//   @override
//   Future<void> onLoad() async {
//     super.onLoad();

//     // Cambiar el fondo a una imagen de caminos
//     background = SpriteComponent()
//       ..sprite = await loadSprite('back.png') // Asegúrate de tener esta imagen
//       ..size = size;
//     add(background);

//     // Cargar el sprite del jugador
//     player = SpriteComponent()
//       ..sprite = await loadSprite('character1.png')
//       ..size = Vector2(50, 50)
//       ..position = Vector2(size.x / 2, size.y - 60);
//     add(player);

//     // Cargar el texto del terminal
//     terminal = TextComponent(
//       text: terminalLines.join('\n'),
//       textRenderer: TextPaint(
//         style: TextStyle(
//           color: Colors.green,
//           fontSize: 12,
//           fontFamily: 'FiraCode',
//         ),
//       ),
//       position: Vector2(10, 10),
//     );
//     add(terminal);

//     // Cargar la animación de Rive para la niebla
//     fog = RiveComponent(
//       artboard: await loadRiveArtboard('assets/headerslime.riv.riv',
//           artboardName: 'Fog'),
//       size: Vector2(size.x, size.y / 2),
//       position: Vector2(0, size.y / 2),
//     );
//     add(fog);
//   }

//   void addTerminalLine(String line) {
//     terminalLines.add(line);
//     terminal.text = terminalLines.join('\n');
//   }

//   @override
//   void onTapDown(TapDownInfo info) {
//     super.onTapDown(info); // Corrección del método
//     final touchPosition =
//         info.eventPosition.global; // Corrección en la obtención de la posición

//     // Determinar en qué ruta tocaron
//     if (touchPosition.x < size.x / 3) {
//       player.position.x = size.x / 6; // Ruta izquierda
//     } else if (touchPosition.x < 2 * size.x / 3) {
//       player.position.x = size.x / 2; // Ruta del medio
//     } else {
//       player.position.x = 5 * size.x / 6; // Ruta derecha
//     }
//   }

//   @override
//   void onKeyEvent(RawKeyEvent event) {
//     super.onKeyEvent(event);
//     if (event is RawKeyDownEvent) {
//       switch (event.logicalKey.keyLabel) {
//         case 'w':
//           player.position.y -= 10;
//           break;
//         case 'a':
//           player.position.x -= 10;
//           break;
//         case 's':
//           player.position.y += 10;
//           break;
//         case 'd':
//           player.position.x += 10;
//           break;
//       }
//     }
//   }
// }
