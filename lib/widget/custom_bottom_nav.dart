import 'package:flutter/material.dart';
import 'package:music_app_project/provider/navigation_provider.dart';
import 'package:music_app_project/view/home_screen.dart';
import 'package:music_app_project/view/library_screen.dart';
import 'package:music_app_project/view/playlist_screen.dart';
import 'package:music_app_project/view/profile_screen.dart';
import 'package:music_app_project/view/search_screen.dart';
import 'package:provider/provider.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final navigation = context.watch<NavigationProvider>();

    final screens = const [
      HomeScreen(),
      SearchScreen(),
      LibraryScreen(),
      PlaylistScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xff111827),

      body: IndexedStack(index: navigation.currentIndex, children: screens),

      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          decoration: BoxDecoration(
            color: const Color(0xff1C1F2E),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.25),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BottomNavigationBar(
              currentIndex: navigation.currentIndex,

              onTap: (index) {
                context.read<NavigationProvider>().changeIndex(index);
              },

              type: BottomNavigationBarType.fixed,
              elevation: 0,
              backgroundColor: Colors.transparent,

              selectedItemColor: const Color(0xff8B5CF6),
              unselectedItemColor: Colors.white54,

              selectedFontSize: 11,
              unselectedFontSize: 11,

              iconSize: 22,

              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_rounded),
                  label: "Search",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_music_rounded),
                  label: "Library",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.queue_music_rounded),
                  label: "Playlist",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
