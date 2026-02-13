import 'package:hive/hive.dart';

part 'note_model.g.dart';

const String notesBoxName = 'notes';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime createdDate;

  @HiveField(3)
  String summarize;

  Note({
    required this.title,
    required this.content,
    required this.createdDate,
    required this.summarize,
  });

  Note copyWith({
    String? title,
    String? content,
    DateTime? createdDate,
    String? summarize,
  }) {
    return Note(
      title: title ?? this.title,
      content: content ?? this.content,
      createdDate: createdDate ?? this.createdDate,
      summarize: summarize ?? this.summarize,
    );
  }
}
