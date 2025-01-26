import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloudinary_midu/config/const.dart';
import 'package:cloudinary_midu/models/image_prompt.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'image_prompt_event.dart';
part 'image_prompt_state.dart';

class ImagePromptBloc extends Cubit<ImagePromptState> {
  static const String STORAGE_KEY = 'saved_images';

  ImagePromptBloc() : super(const ImagePromptState()) {
    _loadSavedState();
  }
  Future<String> _callUrltransformed() async {
    final apiurl = "${Enviroments.apiUrl}/url";
    final response = await http.get(Uri.parse(apiurl));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['success']) {
        return jsonResponse['data'];
      }
    }
    throw Exception('Failed to load image');
  }

  Future<void> _loadSavedState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedImages = prefs.getStringList(STORAGE_KEY);

    if (savedImages != null) {
      final images = savedImages
          .map((url) => ImagePrompt(
                transformedImageUrl: url,
                isLocked: true,
              ))
          .toList();

      emit(state.copyWith(images: images));
    }
  }

  Future<void> _saveState(List<ImagePrompt> images) async {
    final prefs = await SharedPreferences.getInstance();
    final urls = images.map((img) => img.transformedImageUrl).toList();
    await prefs.setStringList(STORAGE_KEY, urls);
  }

  Future<void> generateInitialImages() async {
    emit(state.copyWith(isLoading: true));
    try {
      final images = await Future.wait(
        List.generate(3, (_) async {
          // final imgId = await _callUrltransformed();
          return ImagePrompt(
            transformedImageUrl:
                'https://res.cloudinary.com/generative-ai-demos/image/upload/v1/ugc/replace/ou3vvmue6rrypekwsclr',
          );
        }),
      );
      await _saveState(images);
      emit(state.copyWith(images: images, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> setPromptForImage(int index, String prompt) async {
    if (index >= state.images.length) return;

    final updatedImages = List<ImagePrompt>.from(state.images);
    updatedImages[index] = updatedImages[index].copyWith(isLoading: true);
    emit(state.copyWith(images: updatedImages));

    try {
      // final imgId = await _callUrltransformed();
      final baseUrl =
          'https://res.cloudinary.com/generative-ai-demos/image/upload/';
      final transformedUrl =
          '${baseUrl}e_gen_replace:from_criature;to_${Uri.encodeComponent(prompt)};preserve-geometry_false/f_auto/q_auto/v1/ugc/replace/ou3vvmue6rrypekwsclr';

      final response = await http.get(Uri.parse(transformedUrl));

      if (response.statusCode == 200) {
        updatedImages[index] = ImagePrompt(
          transformedImageUrl:
              '$transformedUrl?t=${DateTime.now().millisecondsSinceEpoch}',
          isLocked: true,
        );
        await _saveState(updatedImages);
        emit(state.copyWith(images: updatedImages));
      }
    } catch (e) {
      updatedImages[index] = updatedImages[index].copyWith(isLoading: false);
      emit(state.copyWith(images: updatedImages));
    }
  }
}
