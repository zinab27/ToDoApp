import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDialog extends StatelessWidget {
  final Function(XFile?) onImageSelected;

  const ImagePickerDialog({required this.onImageSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Image'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            iconColor: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.inversePrimary,
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take a Photo'),
            onTap: () async {
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              onImageSelected(pickedFile);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            iconColor: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.inversePrimary,
            leading: const Icon(Icons.image),
            title: const Text('Choose from Gallery'),
            onTap: () async {
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              onImageSelected(pickedFile);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
