import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickly_app/features/quickly/providers/note_provider.dart';
import 'package:quickly_app/features/quickly/ui/widgets/create_note_dialog.dart';
import 'package:quickly_app/features/quickly/ui/widgets/custom_app_bar.dart';
import 'package:quickly_app/features/quickly/ui/widgets/no_notes.dart';
import 'package:quickly_app/features/quickly/ui/widgets/note_object.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff17171F),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(),

            Expanded(
              child: Consumer<NoteProvider>(
                builder: (context, provider, _) {
                  if (provider.notes.isEmpty) {
                    return Center(child: NoNotes());
                  }

                  return ListView.builder(
                    itemCount: provider.notes.length,
                    itemBuilder: (context, index) {
                      final note = provider.notes[index];
                      return NoteObject(note: note);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SizedBox(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CreateNoteDialog(note: null,),
              );
            },
            shape: CircleBorder(),
            backgroundColor: Color(0xff30AAE9),
            child: Icon(Icons.add, color: Colors.black),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
