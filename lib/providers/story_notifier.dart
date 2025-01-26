import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class StoryState {
  final bool isLoading;
  final String? story;
  final String? error;

  StoryState({this.isLoading = false, this.story, this.error});
}

class StoryNotifier extends StateNotifier<StoryState> {
  StoryNotifier() : super(StoryState());

  Future<void> generateStory(String prompt) async {
    final String apiUrl =
        'https://api-inference.huggingface.co/models/google/gemma-2-2b-jpn-it/v1/chat/completions';
    final String apiKey = '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';

    try {
      state = StoryState(isLoading: true);
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'google/gemma-2-2b-jpn-it',
          'messages': [
            {'role': 'user', 'content': prompt}
          ],
          'max_tokens': 500,
          'stream': false,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        state =
            StoryState(story: responseData['choices'][0]['message']['content']);
      } else {
        state = StoryState(error: 'Failed to generate story');
      }
    } catch (e) {
      state = StoryState(error: e.toString());
    }
  }
}

final storyProvider = StateNotifierProvider<StoryNotifier, StoryState>((ref) {
  return StoryNotifier();
});
