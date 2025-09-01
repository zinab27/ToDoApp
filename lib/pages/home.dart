import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/add.dart';
import 'package:todo/pages/edit.dart';
//import 'package:todo/providers/lightProv.dart';
import 'package:todo/providers/noteProv.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  MyHomePage({super.key});

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
                      return noteProv.notes.isEmpty
                          ? const Center(
                              child: Text('No data available'),
                            )
                          : ListView.builder(
                              itemCount: noteProv.notes.length,
                              itemBuilder: (context, i) {
                                return Card(
                                  color: (i % 2 == 0)
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primaryFixed
                                      : Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                  child: ListTile(
                                    leading: Checkbox(
                                      value: noteProv.notes[i].isCompleted,
                                      onChanged: (value) {
                                        noteProv.toggleCompleteStatus(i);
                                      },
                                    ),
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => NoteEditor(
                                                    index: i,
                                                    availableNotes:
                                                        noteProv.notes,
                                                  )));
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
                                              noteProv.removeNote(i);
                                            },
                                          ).show();
                                        },
                                        icon: const Icon(Icons.delete)),
                                    title: Text(
                                      noteProv.notes[i].title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              noteProv.notes[i].isCompleted
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                          decorationColor:
                                              noteProv.notes[i].isCompleted
                                                  ? Colors.black
                                                  : Colors.transparent,
                                          decorationThickness: 2.5),
                                    ),
                                    subtitle: Text(
                                      noteProv.notes[i].description,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Add()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
