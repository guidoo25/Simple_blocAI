import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String userkey = 'dchjadopc';
String apiKey = '516484684576488';
String apiSecret = 'JToZcIBE1Q-O0OFMKhBYyPLDevE';

var cloudinary = Cloudinary.fromStringUrl(
    'cloudinary://<${apiKey}>:<${apiSecret}>@<${userkey}>');

Future<String> generateStory(String prompt) async {
  final String apiUrl =
      'https://api-inference.huggingface.co/models/google/gemma-2-2b-jpn-it/v1/chat/completions';
  final String apiKey = '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';
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
    return responseData['choices'][0]['message']['content'];
  } else {
    throw Exception('Failed to generate story');
  }
}

final columnProvider = StateProvider<int>((ref) => 0);
