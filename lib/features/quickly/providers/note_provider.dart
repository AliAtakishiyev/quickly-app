import 'package:flutter/material.dart';
import 'package:quickly_app/features/quickly/data/repositories/note_repository.dart';
import 'package:quickly_app/features/quickly/models/note_model.dart';

class NoteProvider extends ChangeNotifier {
  final NoteRepository _repository = NoteRepository();

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  // Load notes from Hive
  void loadNotes() {
    _notes = _repository.getAllNotes();
    notifyListeners();
  }

  Future<void> addNote(String title, String content, String summarize) async {
    await _repository.addNote(
      title,
      content,
      DateTime.now(),
      DateTime.now(),
      summarize,
    );

    loadNotes(); // refresh list
  }

  Future<void> deleteNote(int hiveId) async {
    await _repository.deleteNote(hiveId);
    loadNotes();
  }

  Future<void> editNote(String title, String content, int hiveId) async {
    await _repository.editNote(title, content, hiveId);
    loadNotes();
  }

  Future<void> addSummarize(String summarize, int hiveId) async {
    await _repository.addSummarize(summarize, hiveId);
    loadNotes();
  }
}
