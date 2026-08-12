import 'package:flutter/material.dart';
import 'package:music_app_project/widgets/custom_bottom_nav.dart';
import 'package:provider/provider.dart';

import 'providers/navigation_provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/player_provider.dart';
// import 'providers/playlist_provider.dart';
import 'providers/search_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => PlayerProvider()),
        // ChangeNotifierProvider(create: (_) => PlaylistProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: MyApp(),
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
