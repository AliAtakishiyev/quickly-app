import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quickly_app/features/quickly/models/note_model.dart';
import 'package:quickly_app/features/quickly/providers/note_provider.dart';
import 'package:quickly_app/features/quickly/ui/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>(notesBoxName);

  //   if (Hive.isBoxOpen('notes')) {
  //   await Hive.box<Note>('notes').close();
  // }

  // await Hive.deleteBoxFromDisk('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoteProvider()..loadNotes(),
      child: MaterialApp(
        title: 'Quickly',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
