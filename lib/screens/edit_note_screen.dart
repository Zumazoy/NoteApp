import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import '../models/note_model.dart';

class EditNoteScreen extends StatefulWidget {
  final String noteId;

  const EditNoteScreen({super.key, required this.noteId});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    final note = notesProvider.notes.firstWhere(
      (note) => note.id == widget.noteId,
      orElse: () => Note(id: '', text: '', createdAt: DateTime.now()),
    );
    _controller = TextEditingController(text: note.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать заметку'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveNote),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Текст заметки',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              minLines: 1,
              autofocus: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNote,
              child: const Text('Сохранить изменения'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveNote() {
    if (_controller.text.trim().isNotEmpty) {
      Provider.of<NotesProvider>(
        context,
        listen: false,
      ).editNote(widget.noteId, _controller.text);
      Navigator.pop(context);
    }
  }
}
