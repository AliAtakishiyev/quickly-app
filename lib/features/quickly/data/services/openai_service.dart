import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String _baseUrl = 'https://api.openai.com/v1/chat/completions';

  String get _apiKey {
    final key = dotenv.env['OPENAI_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('OPENAI_API_KEY is not set in .env');
    }
    return key;
  }

  Future<String> summarizeNote(String content) async {
    final uri = Uri.parse(_baseUrl);

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4.1-mini', // or another available model
        'messages': [
          {
            'role': 'system',
            'content':
                ' You summarize notes. STRICT RULES: Maximum 2 sentences. Maximum 40 words. No extra explanation. No intro text.',
          },
          {
            'role': 'user',
            'content': 'Summarize this note in max 2-3 sentences:\n\n$content',
          },
        ],
        'temperature': 0.4,
        'max_tokens': 80,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'OpenAI API error: ${response.statusCode} - ${response.body}',
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final choices = data['choices'] as List<dynamic>?;
    if (choices == null || choices.isEmpty) {
      throw Exception('No choices returned from OpenAI.');
    }

    final message = choices.first['message'] as Map<String, dynamic>?;
    final summary = message?['content'] as String?;
    if (summary == null || summary.isEmpty) {
      throw Exception('Empty summary returned from OpenAI.');
    }

    return summary.trim();
  }
}
