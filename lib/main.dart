import 'package:flutter/material.dart';
import 'package:todo/pages/add.dart';
import 'package:todo/pages/all.dart';
import 'package:todo/pages/home.dart';
import 'package:todo/providers/lightProv.dart';
import 'package:todo/providers/noteProv.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => NoteProvider()),
    ChangeNotifierProvider(create: (context) => LightProvider()),
  ], child: const MyApp()));
}

var gColorScheme = ColorScheme.fromSeed(seedColor: Colors.orange);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<LightProvider>(builder: (_, lightprov, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: lightprov.mode,
          darkTheme: ThemeData.dark().copyWith(
            colorScheme: gColorScheme,
            iconTheme: const IconThemeData().copyWith(
              color: gColorScheme.inversePrimary,
            ),
            bottomNavigationBarTheme:
                const BottomNavigationBarThemeData().copyWith(
                    selectedItemColor: gColorScheme.inversePrimary,
                    selectedIconTheme: const IconThemeData().copyWith(
                      color: gColorScheme.inversePrimary,
                    )),
          ),
          title: 'LIST OF TO DO',
          theme: ThemeData().copyWith(
              colorScheme: gColorScheme,
              iconTheme: const IconThemeData().copyWith(
                color: gColorScheme.inversePrimary,
              ),
              bottomNavigationBarTheme:
                  const BottomNavigationBarThemeData().copyWith(
                      selectedItemColor: gColorScheme.primary,
                      selectedIconTheme: const IconThemeData().copyWith(
                        color: gColorScheme.primary,
                      ))),
          home: const All(),
          routes: {
            'add': (context) => const Add(),
            'home': (context) => MyHomePage(),
            'all': (context) => const All(),
          },
        );
      }),
    );
  }
}
