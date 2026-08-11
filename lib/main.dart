import 'package:flutter/material.dart';
import 'package:music_app_project/view/library_screen.dart';

void main() {
     runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0E17),
      ),
      home: LibraryScreen(),
    );
  }
}
