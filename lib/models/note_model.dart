import 'package:intl/intl.dart';

class Note {
  final String id;
  final String text;
  final DateTime createdAt;

  Note({required this.id, required this.text, required this.createdAt});

  String get formattedCreatedAt {
    final formatter = DateFormat('dd.MM.yyyy HH:mm:ss');
    return formatter.format(createdAt);
  }
}
