import 'dart:convert';

import 'package:todo/data/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveData(Note newNote) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString('data');
  List<Note> noteList = decodeJson(jsonString);
  noteList.add(newNote);
  await prefs.setString(
      'data', jsonEncode(noteList.map((note) => note.toMap()).toList()));
}

Future<List<Note>> getData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString('data');
  return decodeJson(jsonString);
}

Future<void> removeItem(int index) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString('data');
  List<Note> noteList = decodeJson(jsonString);
  if (index >= 0 && index < noteList.length) {
    noteList.removeAt(index);
    await prefs.setString(
        'data', jsonEncode(noteList.map((note) => note.toMap()).toList()));
  }
}

List<Note> decodeJson(String? jsonString) {
  if (jsonString == null) return [];
  try {
    List<dynamic> decodedData = jsonDecode(jsonString);
    List<Note> notes = decodedData
        .where((item) => item != null)
        .map((item) => Note.fromMap(Map<String, dynamic>.from(item)))
        .toList();

    return notes;
  } catch (e) {
    print('Error parsing JSON: $e');
    return [];
  }
}

Future<void> updateNoteInData(int index, Note updatedNote) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString('data');
  List<Note> noteList = decodeJson(jsonString);
  if (index >= 0 && index < noteList.length) {
    noteList[index] = updatedNote;
    await prefs.setString(
        'data', jsonEncode(noteList.map((note) => note.toMap()).toList()));
  }
}
