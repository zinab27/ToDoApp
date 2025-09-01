class Note {
  String title;
  String description;
  DateTime? date;
  bool isCompleted;
  String? imagePath; // New field for the image path

  Note({
    required this.title,
    required this.description,
    this.date,
    this.isCompleted = false,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date?.toIso8601String(),
      'isCompleted': isCompleted,
      'imagePath': imagePath,
    };
  }

  //In Dart, the factory keyword is used to define a factory constructor.
  // A factory constructor is a special type of constructor that can return instances
  // of the class, but it is not required to create a new instance each time it is called.
  // Instead, it can return an existing instance or perform some other logic.
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'],
      description: map['description'],
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
      isCompleted: map['isCompleted'] ?? false,
      imagePath: map['imagePath'],
    );
  }
}
