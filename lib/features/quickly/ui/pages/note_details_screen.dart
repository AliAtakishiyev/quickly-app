import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickly_app/features/quickly/providers/note_provider.dart';
import 'package:quickly_app/features/quickly/providers/openai_provider.dart';
import 'package:quickly_app/features/quickly/ui/widgets/edit_note_dialog.dart';
import 'package:quickly_app/features/quickly/ui/widgets/go_back.dart';
import 'package:quickly_app/features/quickly/ui/widgets/summary_ai.dart';

class NoteDetailsScreen extends StatelessWidget {
  final dynamic note;
  final dynamic date;

  const NoteDetailsScreen({super.key, required this.note, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff17171F),
      body: SafeArea(
        child: Consumer<NoteProvider>(
          builder: (context, noteProvider, child) {
            // Get the current note from provider using the key
            final currentNote = noteProvider.notes.firstWhere(
              (n) => n.key == note.key,
              orElse: () => note, // Fallback to original if not found
            );

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GoBack(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentNote.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          date.toString(),
                          style: TextStyle(
                            color: Color(0xff707785),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          currentNote.content.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),

                        //summarize here
                        Consumer<OpenaiProvider>(
                          builder: (context, ai, child) {
                            if (ai.isLoading) {
                              return Center(
                                child: const CircularProgressIndicator(
                                  color: Color(0xff30AAE9),
                                ),
                              );
                            }

                            if (ai.error != null) {
                              return Text(
                                ai.error!,
                                style: const TextStyle(color: Colors.red),
                              );
                            }

                            if (ai.summary != null) {
                              return SummaryAi(summary: ai.summary);
                            }

                            return const SizedBox.shrink();
                          },
                        ),

                        Container(height: 1, color: Color(0xff32343F)),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (context) =>
                                        EditNoteDialog(note: currentNote),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                label: const Text(
                                  'Edit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff2D2D3A),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  context.read<OpenaiProvider>().summarizeNote(
                                    note.content,
                                  );
                                },
                                icon: const Icon(
                                  Icons.auto_awesome_outlined,
                                  color: Color(0xff17171F),
                                  size: 20,
                                ),
                                label: const Text(
                                  'Summarize',
                                  style: TextStyle(
                                    color: Color(0xff17171F),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff30AAE9),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  await context.read<NoteProvider>().deleteNote(
                                    currentNote.key,
                                  );
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Color(0xffFF6B6B),
                                  size: 20,
                                ),
                                label: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Color(0xffFF6B6B),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff2D2D3A),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
