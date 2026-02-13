import 'package:flutter/material.dart';
import 'package:quickly_app/features/quickly/data/repositories/openai_repositories.dart';

class OpenaiProvider extends ChangeNotifier {
  final OpenaiRepositories _repository;

  OpenaiProvider(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _summary;
  String? get summary => _summary;

  String? _error;
  String? get error => _error;

  void clearSummary() {
    _summary = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> summarizeNote(String content) async {
    try {
      _isLoading = true;
      _error = null;
      _summary = null;
      notifyListeners();

      final result = await _repository.summarize(content);

      _summary = result;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _summary = null;
    _error = null;
    notifyListeners();
  }
}
