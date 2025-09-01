import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo/data/data.dart';
import 'package:todo/data/note.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class NoteProvider with ChangeNotifier {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  List<Note> _notes = [];
  List<Note> _completedNotes = [];
  List<Note> _missedNotes = [];

  List<Note> get notes => _notes;
  List<Note> get completedNotes => _completedNotes;
  List<Note> get missedNotes => _missedNotes;

  NoteProvider() {
    tz.initializeTimeZones();
    loadNotes();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> loadNotes() async {
    _notes = await getData();
    updateNotesLists();
  }

  Future<void> addNote(Note note) async {
    await saveData(note);
    _notes.add(note);
    updateNotesLists();
    await scheduleNotificationForNote(note);
  }

  Future<void> removeNote(int index) async {
    await removeItem(index);
    _notes.removeAt(index);
    await flutterLocalNotificationsPlugin.cancel(_notes[index].hashCode);
    updateNotesLists();
  }

  Future<void> updateNote(int index, Note note) async {
    await updateNoteInData(index, note);
    _notes[index] = note;
    updateNotesLists();
    await updateNotificationForNote(index, note);
  }

  void toggleCompleteStatus(int index) async {
    final note = _notes[index];
    note.isCompleted = !note.isCompleted;
    await updateNoteInData(index, note);
    updateNotesLists();
  }

  void updateNotesLists() {
    _completedNotes = _notes.where((note) => note.isCompleted).toList();
    _missedNotes = _notes
        .where((note) =>
            !note.isCompleted &&
            note.date != null &&
            note.date!
                .isBefore(DateTime.now().subtract(const Duration(days: 1))))
        .toList();
    notifyListeners();
  }

  Future<void> requestExactAlarmPermission() async {
    if (await Permission.scheduleExactAlarm.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }
  }

  Future<void> scheduleNotificationForNote(Note note) async {
    await requestExactAlarmPermission();
    if (note.date != null) {
      try {
        var notificationTime = note.date!.subtract(const Duration(days: 1));
        //var date = DateTime(2024, 9, 4, 17, 41, 10);
        final location = tz.getLocation('Africa/Cairo');
        //print("=====local=====$location");
        tz.TZDateTime scheduledTime =
            tz.TZDateTime.from(notificationTime, location);
        //print('Scheduling notification for ${note.title} at $scheduledTime');
        await flutterLocalNotificationsPlugin.zonedSchedule(
          note.hashCode,
          'Note Reminder',
          '${note.title} deadline is approaching!',
          scheduledTime,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'nameId2',
              'Channel_Name',
              icon: '@mipmap/ic_launcher',
              //color: Colors.white,
              importance: Importance
                  .max, //to show the message when the notification sends
            ),
            iOS: DarwinNotificationDetails(),
          ),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );

        //print('Notification scheduled successfully for ${note.title}.');
      } catch (e) {
        print('Error scheduling notification for ${note.title}: $e');
      }
    }
  }

  Future<void> updateNotificationForNote(int index, Note note) async {
    await flutterLocalNotificationsPlugin.cancel(note.hashCode);
    await scheduleNotificationForNote(note);
  }
}
