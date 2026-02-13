import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quickly_app/features/quickly/data/repositories/openai_repositories.dart';
import 'package:quickly_app/features/quickly/data/services/openai_service.dart';
import 'package:quickly_app/features/quickly/models/note_model.dart';
import 'package:quickly_app/features/quickly/providers/note_provider.dart';
import 'package:quickly_app/features/quickly/providers/openai_provider.dart';
import 'package:quickly_app/features/quickly/ui/pages/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final openAIService = OpenAIService();
  final openAIRepository = OpenaiRepositories(openAIService);

  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());

  if (await Hive.boxExists(notesBoxName)) {
    if (Hive.isBoxOpen(notesBoxName)) {
      await Hive.box<Note>(notesBoxName).close();
    }
    //await Hive.deleteBoxFromDisk(notesBoxName);
  }

  await Hive.openBox<Note>(notesBoxName);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OpenaiProvider(openAIRepository)),
      ],

      child: const MyApp(),
    ),
  );
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
