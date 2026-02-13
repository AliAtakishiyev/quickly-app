import 'package:flutter/material.dart';
import 'package:quickly_app/features/quickly/data/repositories/openai_repositories.dart';

class OpenaiProvider extends ChangeNotifier {
  final OpenaiRepositories _repository;

  OpenaiProvider(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<String?> summarizeNote(String content) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final summary = await _repository.summarize(content);

      _isLoading = false;
      notifyListeners();

      return summary;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }
}
