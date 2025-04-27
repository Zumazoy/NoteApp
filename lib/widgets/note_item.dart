import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note_model.dart';
import '../providers/notes_provider.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final int index;

  const NoteItem({super.key, required this.note, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        title: Text(note.text),
        subtitle: Text(
          'Создано: ${note.formattedCreatedAt}',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed:
                  () =>
                      Navigator.pushNamed(context, '/edit', arguments: note.id),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed:
                  () => Provider.of<NotesProvider>(
                    context,
                    listen: false,
                  ).deleteNote(note.id),
            ),
          ],
        ),
      ),
    );
  }
}
