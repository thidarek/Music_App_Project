import 'package:flutter/material.dart';
// import 'package:music_app_project/models/artist.dart';
// import 'package:music_app_project/models/playlist.dart';
// import 'package:music_app_project/models/song.dart';
// Import your dummy data file (e.g., data.dart or wherever artists, songs, playlists are exported)
import 'package:music_app_project/data/mock_data.dart';
import 'package:provider/provider.dart';
import 'package:music_app_project/providers/favorite_provider.dart';
import 'package:music_app_project/view/favorites_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // UI Colors matching the target theme
    const backgroundColor = Color(0xFF0C101A);
    const cardColor = Color(0xFF181E2B);
    const primaryPurple = Color(0xFF7C5CFC);
    const secondaryTextColor = Color(0xFF8F9BB3);

    // Derived stats from your actual data model arrays
    // Use FavoriteProvider if available to show accurate favorite count
    // Fallback to 0 if provider not available in this context
    final favoriteSongsCount = Provider.of<FavoriteProvider>(context).favoriteCount;
    final totalArtistsCount = artists.length;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Library Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Area
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage('assets/images/artists/the_weeknd.jpg'),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Library',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.notifications_none, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Search Bar
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: cardColor,
                        hintText: 'Search your library',
                        hintStyle: const TextStyle(color: secondaryTextColor, fontSize: 14),
                        prefixIcon: const Icon(Icons.search, color: secondaryTextColor),
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),

                    const SizedBox(height: 20),

                    // Quick Nav Categories
                    _buildCategoryTile(
                      icon: Icons.favorite,
                      iconBgColor: primaryPurple,
                      title: 'Favorite Songs',
                      subtitle: '$favoriteSongsCount tracks',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoritesScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildCategoryTile(
                      icon: Icons.download_outlined,
                      iconBgColor: Colors.white12,
                      title: 'Downloads',
                      subtitle: 'Available offline',
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    _buildCategoryTile(
                      icon: Icons.album_outlined,
                      iconBgColor: Colors.white12,
                      title: 'Albums',
                      subtitle: '${playlists.length} Saved collections',
                      onTap: () {},
                    ),
                    const SizedBox(height: 10),
                    _buildCategoryTile(
                      icon: Icons.person_outline,
                      iconBgColor: Colors.white12,
                      title: 'Artists',
                      subtitle: 'Following $totalArtistsCount artists',
                      onTap: () {},
                    ),

                    const SizedBox(height: 24),

                    // Recent Activity Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Activity',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'View all',
                            style: TextStyle(color: primaryPurple),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Banner Widget (Using First Playlist/Song Model)
                    if (songs.isNotEmpty)
                      Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: NetworkImage(songs.first.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [Colors.black.withOpacity(0.85), Colors.transparent],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'ON ROTATION',
                                style: TextStyle(
                                  color: primaryPurple,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                songs.first.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    // Dynamic Grid displaying Playlists from model
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: playlists.length > 2 ? 2 : playlists.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.85,
                      ),
                      itemBuilder: (context, index) {
                        final playlist = playlists[index];
                        final String displayImage = playlist.songs.isNotEmpty && playlist.songs.first.image.isNotEmpty
                            ? playlist.songs.first.image
                            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5-f_ybMoiTZGNvCjQgCW_BSZs8gnN0wR7zja2O6FjBL0Odk2Ti2-aM2CVCZnaOmkbuHpz7QgpiZBZ-KEwS3p2GzL24h6Q9gscTQgqbQ&s=10';

                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    displayImage,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: Colors.white10,
                                      child: const Icon(Icons.music_note, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                playlist.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Playlist • ${playlist.songs.length} songs',
                                style: const TextStyle(
                                  color: secondaryTextColor,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Persistent Mini Player (bound to songs[0] model)
            if (songs.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        songs[0].image,
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 44,
                          height: 44,
                          color: Colors.white10,
                          child: const Icon(Icons.music_note, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            songs[0].title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            songs[0].artist,
                            style: const TextStyle(
                              color: secondaryTextColor,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.cast, color: Colors.white70),
                      onPressed: () {},
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 18,
                      child: IconButton(
                        icon: const Icon(Icons.pause, color: Colors.black, size: 20),
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: backgroundColor,
      //   selectedItemColor: primaryPurple,
      //   unselectedItemColor: secondaryTextColor,
      //   currentIndex: 2,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      //     BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Library'),
      //     BottomNavigationBarItem(icon: Icon(Icons.playlist_play), label: 'Playlist'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      //   ],
      // ),
    );
  }

  // Helper tile for category menu
  Widget _buildCategoryTile({
    required IconData icon,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF181E2B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Color(0xFF8F9BB3), fontSize: 12),
        ),
        trailing: const Icon(Icons.chevron_right, color: Color(0xFF8F9BB3)),
      ),
    );
  }
}