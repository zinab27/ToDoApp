import 'package:flutter/material.dart';
import 'package:todo/pages/edit.dart';
import 'package:todo/providers/noteProv.dart';
import 'package:provider/provider.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              const Text(
                'Welcome to Notes App',
                style: TextStyle(fontSize: 24),
              ),
              Expanded(
                child: Consumer<NoteProvider>(
                  builder: (context, noteProv, child) {
                    final completed = noteProv.completedNotes;
                    return completed.isEmpty
                        ? const Center(
                            child: Text('No Completed Notes available'),
                          )
                        : ListView.builder(
                            itemCount: completed.length,
                            itemBuilder: (context, i) {
                              return Card(
                                color: (i % 2 == 0)
                                    ? Theme.of(context).colorScheme.primaryFixed
                                    : Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                child: ListTile(
                                  leading: Checkbox(
                                    value: completed[i].isCompleted,
                                    onChanged: (value) {
                                      int mainIndex =
                                          noteProv.notes.indexOf(completed[i]);
                                      noteProv.toggleCompleteStatus(mainIndex);
                                    },
                                  ),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => NoteEditor(
                                                  index: noteProv.notes
                                                      .indexOf(completed[i]),
                                                  availableNotes:
                                                      noteProv.notes,
                                                )));
                                  },
                                  title: Text(
                                    completed[i].title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.black,
                                        decorationThickness: 2.5),
                                  ),
                                  subtitle: Text(
                                    completed[i].description,
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
    );
  }
}
