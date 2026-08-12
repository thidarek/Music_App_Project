import 'package:flutter/material.dart';
import 'package:music_app_project/core/constants/app_colors.dart';
import 'package:music_app_project/core/constants/app_strings.dart';
import 'package:music_app_project/providers/navigation_provider.dart';
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
      backgroundColor: AppColors.navBarBackground,

      body: IndexedStack(index: navigation.currentIndex, children: screens),

      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          decoration: BoxDecoration(
            color: AppColors.navBarBackground,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.25),
                blurRadius: 20,
                offset: Offset(0, 8),
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
              backgroundColor: AppColors.navBarBackground,

              selectedItemColor: AppColors.accentPurple,
              unselectedItemColor: AppColors.navBarInactiveIcon,

              selectedFontSize: 11,
              unselectedFontSize: 11,

              iconSize: 22,

              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: AppStrings.navHome,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_rounded),
                  label: AppStrings.navSearch,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_music_rounded),
                  label: AppStrings.navLibrary,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.queue_music_rounded),
                  label: AppStrings.navPlaylist,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded),
                  label: AppStrings.navProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
