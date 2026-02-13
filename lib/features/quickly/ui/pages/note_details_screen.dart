import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickly_app/features/quickly/models/note_model.dart';
import 'package:quickly_app/features/quickly/providers/note_provider.dart';
import 'package:quickly_app/features/quickly/providers/openai_provider.dart';
import 'package:quickly_app/features/quickly/ui/widgets/edit_note_dialog.dart';
import 'package:quickly_app/features/quickly/ui/widgets/go_back.dart';
import 'package:quickly_app/features/quickly/ui/widgets/summary_ai.dart';

class NoteDetailsScreen extends StatefulWidget {
  final Note note;
  final dynamic date;

  const NoteDetailsScreen({super.key, required this.note, required this.date});

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff17171F),
      body: SafeArea(
        child: Consumer<NoteProvider>(
          builder: (context, noteProvider, child) {
            final currentNote = noteProvider.notes.firstWhere(
              (n) => n.key == widget.note.key,
              orElse: () => widget.note,
            );

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GoBack(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// TITLE
                        Text(
                          currentNote.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        /// DATE
                        Text(
                          widget.date.toString(),
                          style: const TextStyle(
                            color: Color(0xff707785),
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// CONTENT
                        Text(
                          currentNote.content,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// AI + SUMMARY SECTION
                        Consumer<OpenaiProvider>(
                          builder: (context, ai, child) {
                            if (ai.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xff30AAE9),
                                ),
                              );
                            }

                            if (ai.error != null) {
                              return Text(
                                "Connection lost. Please try later",
                                style: const TextStyle(color: Colors.red),
                              );
                            }

                            if (currentNote.summarize.isNotEmpty) {
                              return SummaryAi(summary: currentNote.summarize);
                            }

                            return const SizedBox.shrink();
                          },
                        ),

                        const SizedBox(height: 16),
                        Container(height: 1, color: const Color(0xff32343F)),
                        const SizedBox(height: 12),

                        /// BUTTONS
                        Row(
                          children: [
                            /// EDIT
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
                                ),
                                label: const Text(
                                  'Edit',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff2D2D3A),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            /// SUMMARIZE
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  final ai = context.read<OpenaiProvider>();
                                  final noteProvider = context
                                      .read<NoteProvider>();

                                  final summary = await ai.summarizeNote(
                                    currentNote.content,
                                  );

                                  if (summary != null && summary.isNotEmpty) {
                                    await noteProvider.addSummarize(
                                      summary,
                                      currentNote.key as int,
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Icons.auto_awesome_outlined,
                                  color: Color(0xff17171F),
                                ),
                                label: const Text(
                                  'Summarize',
                                  style: TextStyle(color: Color(0xff17171F)),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff30AAE9),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            /// DELETE
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  await context.read<NoteProvider>().deleteNote(
                                    currentNote.key as int,
                                  );

                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Color(0xffFF6B6B),
                                ),
                                label: const Text(
                                  'Delete',
                                  style: TextStyle(color: Color(0xffFF6B6B)),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff2D2D3A),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
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
