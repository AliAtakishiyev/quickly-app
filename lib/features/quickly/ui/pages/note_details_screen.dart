import 'package:flutter/material.dart';
import 'package:quickly_app/features/quickly/ui/widgets/go_back.dart';

class NoteDetailsScreen extends StatelessWidget {
  final dynamic note;
  
  final dynamic date;

  const NoteDetailsScreen({super.key, required this.note, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff17171F),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GoBack(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Column(
                children: [
                  Text(
                    note.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    date.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
