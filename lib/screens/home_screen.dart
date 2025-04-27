import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import '../widgets/note_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заметки'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/add'),
          ),
        ],
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, _) {
          if (notesProvider.notes.isEmpty) {
            return const Center(child: Text('Нет заметок, добавьте новую'));
          }
          return ReorderableListView.builder(
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: notesProvider.notes.length,
            itemBuilder:
                (context, index) => NoteItem(
                  key: Key(notesProvider.notes[index].id),
                  note: notesProvider.notes[index],
                  index: index,
                ),
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) newIndex--;
              notesProvider.reorderNotes(oldIndex, newIndex);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
