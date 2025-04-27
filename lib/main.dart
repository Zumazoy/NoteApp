import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/notes_provider.dart';
import 'screens/home_screen.dart';
import 'screens/add_note_screen.dart';
import 'screens/edit_note_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NotesProvider())],
      child: MaterialApp(
        title: 'Заметки',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/add': (context) => const AddNoteScreen(),
          '/edit': (context) {
            final noteId = ModalRoute.of(context)!.settings.arguments as String;
            return EditNoteScreen(noteId: noteId);
          },
        },
      ),
    );
  }
}
