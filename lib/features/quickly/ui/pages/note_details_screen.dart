import 'package:flutter/material.dart';
import 'package:quickly_app/features/quickly/ui/widgets/go_back.dart';

class NoteDetailsScreen extends StatelessWidget {
  final dynamic note;

  const NoteDetailsScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff17171F),
      body: SafeArea(child: Column(children: [GoBack()])),
    );
  }
}
