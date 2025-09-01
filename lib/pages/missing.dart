import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/edit.dart';
import 'package:todo/providers/noteProv.dart';
import 'package:provider/provider.dart';

class MissingPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  MissingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to Notes App',
                  style: TextStyle(fontSize: 24),
                ),
                Expanded(
                  child: Consumer<NoteProvider>(
                    builder: (context, noteProv, child) {
                      final missingNotes = noteProv.missedNotes;
                      return missingNotes.isEmpty
                          ? const Center(
                              child: Text('No Missed Notes available'),
                            )
                          : ListView.builder(
                              itemCount: missingNotes.length,
                              itemBuilder: (context, i) {
                                final note = missingNotes[i];
                                return Card(
                                  color: (i % 2 == 0)
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primaryFixed
                                      : Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => NoteEditor(
                                            index: noteProv.notes.indexOf(note),
                                            availableNotes: noteProv.notes,
                                          ),
                                        ),
                                      );
                                    },
                                    trailing: IconButton(
                                      onPressed: () async {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.warning,
                                          animType: AnimType.rightSlide,
                                          title: 'Warning',
                                          desc:
                                              'Are you sure to delete this note ?',
                                          btnCancelOnPress: () {},
                                          btnOkOnPress: () {
                                            //noteProv.removeNote(i);
                                            noteProv.removeNote(
                                              noteProv.notes.indexOf(note),
                                            );
                                          },
                                        ).show();
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                    title: Text(
                                      note.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: note.isCompleted
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                    subtitle: Text(
                                      note.description,
                                    ),
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
