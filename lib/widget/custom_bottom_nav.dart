import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F1526),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_filled, 'Home', 0),
          _navItem(Icons.search, 'Search', 1),
          _navItem(Icons.grid_view_rounded, 'Library', 2),
          _navItem(Icons.queue_music, 'Playlist', 3),
          _navItem(Icons.person_outline, 'Profile', 4),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;
    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFFB388FF) : Colors.white38,
            size: 22,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFFB388FF) : Colors.white38,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
