import 'package:flutter/material.dart';

class Enviroments {
  static String apiUrl = 'http://localhost/api_music/api';
}

class AppConstants {
  // Obtener el ancho de la pantalla
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Obtener el alto de la pantalla
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Tamaño de las imágenes
  static double getImageWidth(BuildContext context) {
    return getScreenWidth(context) /
        3; // Divide el ancho de la pantalla entre 3
  }

  static double getImageHeight(BuildContext context) {
    return 200.0; // Altura fija para las imágenes
  }
}
