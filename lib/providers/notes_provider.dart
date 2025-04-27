import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NotesProvider extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => _notes;

  void addNote(String text) {
    if (text.trim().isEmpty) return;
    _notes.add(
      Note(
        id: DateTime.now().toString(),
        text: text,
        createdAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void editNote(String id, String newText) {
    if (newText.trim().isEmpty) return;
    final index = _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      _notes[index] = Note(
        id: _notes[index].id,
        text: newText,
        createdAt: _notes[index].createdAt,
      );
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void reorderNotes(int oldIndex, int newIndex) {
    if (oldIndex < 0 ||
        newIndex < 0 ||
        oldIndex >= _notes.length ||
        newIndex >= _notes.length) {
      return;
    }

    final item = _notes.removeAt(oldIndex);
    _notes.insert(newIndex, item);
    notifyListeners();
  }
}
