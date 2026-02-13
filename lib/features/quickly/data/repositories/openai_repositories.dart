import 'package:quickly_app/features/quickly/data/services/openai_service.dart';

class OpenaiRepositories {
  final OpenAIService _service;

  OpenaiRepositories(this._service);

  Future<String> summarize(String content) async {
    return await _service.summarizeNote(content);
  }
}
