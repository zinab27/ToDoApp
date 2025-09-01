# ToDoApp — Flutter To‑Do Application

A clean, performant, and responsive **Flutter** application to manage your daily tasks across all platforms with rich features and customization.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-success?style=for-the-badge)

---

## 📌 Features

- **Add Tasks**: Create new to-do items with title, description, date, and optional image.
- **Edit Tasks**: Update existing tasks, including changing title, description, date, and image.
- **Delete Tasks**: Remove tasks from your list.
- **View All Tasks**: See all your to-do items in a single list.
- **Completed Tasks**: Mark tasks as completed and view them separately.
- **Missed Tasks**: View tasks that are past their due date.
- **Image Picker**: Attach images to tasks using the device gallery or camera.
- **Theme Switching**: Toggle between light and dark modes.
- **Persistent Storage**: Tasks are saved locally using shared preferences.
- **Local Notifications**: Get reminders for upcoming tasks.
- **Responsive UI**: Works on **Android, iOS, Web, Windows, macOS, and Linux**.

---

## 📂 Project Structure

```
lib/
├── main.dart                # App entry point & theme setup
├── data/
│   ├── data.dart            # Data management logic
│   └── note.dart            # Note/task model
├── pages/
│   ├── home.dart            # Main task list screen
│   ├── add.dart             # Add new task screen
│   ├── edit.dart            # Edit task screen
│   ├── all.dart             # All tasks view
│   ├── donePage.dart        # Completed tasks view
│   ├── missing.dart         # Missed tasks view
│   ├── imagePickerDialog.dart # Image picker dialog
├── providers/
│   ├── noteProv.dart        # Task/note state management
│   └── lightProv.dart       # Theme state management
assets/
└── noteLogo.png             # App logo and static assets
pubspec.yaml                 # Project dependencies &
```

---

## 📦 Dependencies

The project uses the following Flutter packages:

| Package                         | Version | Usage                                                    |
| ------------------------------- | ------- | -------------------------------------------------------- |
| **flutter**                     | sdk     | Core Flutter framework                                   |
| **cupertino_icons**             | ^1.0.8  | iOS style icons                                          |
| **shared_preferences**          | ^2.3.2  | Local storage for tasks                                  |
| **awesome_dialog**              | ^3.2.1  | Beautiful dialogs and alerts                             |
| **provider**                    | ^6.1.2  | State management (theme, tasks)                          |
| **image_picker**                | ^1.1.2  | Pick images from gallery or camera                       |
| **intl**                        | ^0.19.0 | Date & time formatting                                   |
| **flutter_local_notifications** | ^17.2.2 | Local notifications & reminders                          |
| **flutter_timezone**            | ^3.0.1  | Timezone detection for scheduling                        |
| **timezone**                    | ^0.9.4  | Timezone-based scheduling                                |
| **permission_handler**          | ^11.3.1 | Manage runtime permissions (camera, notifications, etc.) |

---

## 🚀 Getting Started

### Prerequisites

- Install Flutter following the official [Flutter install guide](https://docs.flutter.dev/get-started/install).

### Installation Steps

```bash
git clone https://github.com/zinab27/ToDoApp.git
cd ToDoApp
flutter pub get
flutter run
```

---

## 📝 Usage Walkthrough

1. **Home Screen** – Browse all tasks. Swipe or tap to mark as complete, edit, or delete.
2. **Adding a Task** – Tap the “+” button to open the form. Enter details and attach an optional image.
3. **Editing a Task** – Select a task to edit its fields.
4. **Task Filters** – Switch between Active, Completed, or Missed tasks.
5. **Theme Toggle** – Switch between light and dark modes.

---

## 💾 Persistent Data Storage

This app uses [`shared_preferences`](https://pub.dev/packages/shared_preferences) to store tasks locally.  
Data persists across sessions, ensuring your tasks are not lost after closing the app.

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the repository
2. Create a new branch (e.g. `feature/image-optimization`)
3. Make your changes & test them
4. Submit a Pull Request