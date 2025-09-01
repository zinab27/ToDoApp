import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/note.dart';
import 'package:todo/pages/imagePickerDialog.dart';
import 'package:todo/providers/noteProv.dart';
import 'package:provider/provider.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

/*
  final ImagePicker picker = ImagePicker();
  String? _imagePath;

  Future<void> pickImage() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path;
      });
    }
  }*/

  DateTime? _selectedDate;
  Future<void> _datePicker() async {
    var now = DateTime.now();
    var last = DateTime(now.year + 5, now.month, now.day);
    var firstDate = DateTime(now.year - 5, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: last,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  XFile? _imageFile;
  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ImagePickerDialog(
          onImageSelected: (pickedFile) {
            setState(() {
              _imageFile = pickedFile;
            });
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter the Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _descriptionController,
                minLines: 3,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  hintText: 'Enter the description',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                readOnly: true,
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Selecte Date',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      await _datePicker();
                      setState(() {
                        _dateController.text = _selectedDate == null
                            ? "No date selected"
                            : DateFormat.yMd().format(_selectedDate!);
                      });
                    },
                    icon: const Icon(Icons.calendar_month),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _showImagePickerDialog,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    _imageFile != null
                        ? Colors.green
                        : Theme.of(context).colorScheme.primaryFixed,
                  ),
                ),
                child: const Text("Select Image"),
              ),
              //if (imagePath != null) Image.file(File(imagePath!)),
              IconButton(
                tooltip: "Save",
                iconSize: 30,
                icon: Icon(
                  Icons.save,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  Note newNote = Note(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      date: _selectedDate,
                      imagePath: _imageFile?.path);

                  print("=============$newNote");

                  Provider.of<NoteProvider>(context, listen: false)
                      .addNote(newNote);
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('all', (context) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
