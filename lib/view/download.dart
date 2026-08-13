import 'package:flutter/material.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});
  static const backgroundColor = Color(0xFF0C101A);
  static const cardColor = Color(0xFF181E2B);
  static const primaryPurple = Color(0xFF9D6BFF);
  static const textSecondary = Color(0xFF8F9BB3);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Downloads', style: TextStyle(color: Colors.white)),
      ),
      body: const Center(
        child: Text('This is the Downloads screen.', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}