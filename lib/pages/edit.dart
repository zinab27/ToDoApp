import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/note.dart';
import 'package:todo/providers/noteProv.dart';
import 'package:provider/provider.dart';

class NoteEditor extends StatefulWidget {
  const NoteEditor(
      {super.key, required this.index, required this.availableNotes});

  final int index;
  final List<Note> availableNotes;

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  final TextEditingController _titleControl = TextEditingController();
  final TextEditingController _descControl = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String? _imagePath;
  DateTime? _selectedDate;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final note = widget.availableNotes[widget.index];
    _titleControl.text = note.title;
    _descControl.text = note.description;
    _imagePath = note.imagePath;
    if (note.date != null) {
      _selectedDate = note.date;
      _dateController.text = DateFormat.yMd().format(note.date!);
    }
  }

  Future<void> pickImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path;
      });
    }
  }

  Future<void> _datePicker() async {
    var now = DateTime.now();
    var last = DateTime(now.year + 5, now.month, now.day);
    var firstDate = DateTime(now.year - 5, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: last,
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat.yMd().format(_selectedDate!);
      });
    }
  }

  @override
  void dispose() {
    _titleControl.dispose();
    _descControl.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _titleControl,
                decoration: const InputDecoration(
                  hintText: 'Enter the Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descControl,
                minLines: 3,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  hintText: 'Enter the description',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                readOnly: true,
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Select Date',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _datePicker,
                    icon: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: pickImage,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    _imagePath != null
                        ? Colors.green
                        : Theme.of(context).colorScheme.primaryFixed,
                  ),
                ),
                child: const Text("Select Image"),
              ),
              const SizedBox(height: 20),
              if (_imagePath != null)
                Image.file(File(_imagePath!), width: 300, height: 500),
              //const SizedBox(height: 20),
              IconButton(
                tooltip: "Save",
                iconSize: 30,
                icon: Icon(
                  Icons.save,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  Note updatedNote = Note(
                    title: _titleControl.text,
                    description: _descControl.text,
                    date: _selectedDate,
                    imagePath: _imagePath,
                  );
                  Provider.of<NoteProvider>(context, listen: false)
                      .updateNote(widget.index, updatedNote);
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('all', (context) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
