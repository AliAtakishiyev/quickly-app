import 'package:hive/hive.dart';
import 'package:quickly_app/features/quickly/models/note_model.dart';

class NoteRepository {
  final box = Hive.box<Note>('notes');

  List<Note> getAllNotes() {
    return box.values.toList();
  }

  Future<int> addNote(
    String title,
    String content,
    DateTime createdDate,
    DateTime editedDate,
    String summarize,
  ) async {
    final note = Note(
      title: title,
      content: content,
      createdDate: createdDate,
      summarize: summarize,
    );
    final id = await box.add(note);
    return id;
  }

  Future<void> deleteNote(int hiveId) async {
    await box.delete(hiveId);
  }

  Future<void> editNote(String title, String content, final hiveId) async {
    final note = box.get(hiveId);

    if (note != null) {
      note.title = title;
      note.content = content;
      note.createdDate = DateTime.now();
      await box.put(hiveId, note);
    }
  }

  Future<void> addSummarize(String summarize, int hiveId) async {
    final note = box.get(hiveId);

    if (note != null) {
      note.summarize = summarize;
      await box.put(hiveId, note);
    }
  }
}
