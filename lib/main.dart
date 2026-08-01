import 'package:flutter/material.dart';
import 'package:music_app_project/widget/custom_bottom_nav.dart';
import 'package:provider/provider.dart';

import 'provider/navigation_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CustomBottomNav(),
    );
  }
}
