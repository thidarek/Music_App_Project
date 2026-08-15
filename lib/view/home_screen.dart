// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:music_app_project/view/playlist_detail_screen.dart';
import '../models/song.dart';
import '../models/artist.dart';
import '../providers/player_provider.dart';
import '../providers/favorite_provider.dart';
import '../data/mock_data.dart';
import 'artist_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const backgroundColor = Color(0xFF0C101A);
  static const cardColor = Color(0xFF181E2B);
  static const primaryPurple = Color(0xFF9D6BFF);
  static const textSecondary = Color(0xFF8F9BB3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar: Profile & Greeting
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Ukrmk8AsNeQazOkSTLUFCtZtvpTlZ9mbK_kmUh5G2UxDzWzV5pvHxClpgY4sLTTSYlwDEpKGDRmo9lIgurbr8_2iMN0Z2yaDAea57pw&s=10',
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back',
                        style: TextStyle(color: textSecondary, fontSize: 12),
                      ),
                      Text(
                        'Good Evening',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // const Spacer(),
                  // IconButton(
                  //   icon: const Icon(Icons.notifications_none, color: Colors.white),
                  //   onPressed: () {},
                  // ),
                ],
              ),
            ),

            // Main Scrollable Body
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 8),

                    // Search Bar Visual Accent
                    // _SearchBarWidget(),
                    SizedBox(height: 20),

                    // Featured Banner Section
                    _FeaturedBanner(),

                    SizedBox(height: 24),

                    // Favorite Artists
                    _FavoriteArtistsSection(),

                    SizedBox(height: 24),

                    // All Songs Section
                    _AllSongsSection(),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Bottom Mini Player
            const _MiniPlayer(),
          ],
        ),
      ),
    );
  }
}

// Helper method to navigate to details cleanly
void _navigateToSongDetail(
  BuildContext context,
  Song song, {
  String playlistName = "Now Playing",
}) {
  Provider.of<PlayerProvider>(context, listen: false).playSong(song);

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          SongDetailScreen(song: song, playlistName: playlistName),
    ),
  );
}

// // ==================== SEARCH BAR ====================
// class _SearchBarWidget extends StatelessWidget {
//   const _SearchBarWidget();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: HomeScreen.cardColor,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: const [
//           Icon(Icons.search, color: HomeScreen.textSecondary, size: 20),
//           SizedBox(width: 12),
//           Text(
//             'Search songs, artists, or albums...',
//             style: TextStyle(color: HomeScreen.textSecondary, fontSize: 14),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ==================== FEATURED BANNER ====================
class _FeaturedBanner extends StatelessWidget {
  const _FeaturedBanner();

  @override
  Widget build(BuildContext context) {
    final featuredSong = songs.isNotEmpty ? songs.first : null;

    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(
            featuredSong?.image ??
                'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=500',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.85), Colors.transparent],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'FEATURED TRACK',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              featuredSong?.title ?? 'Midnight Moods',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                if (featuredSong != null) {
                  _navigateToSongDetail(
                    context,
                    featuredSong,
                    playlistName: "Featured Track",
                  );
                }
              },
              icon: const Icon(Icons.play_arrow, color: Colors.white, size: 18),
              label: const Text(
                'Play Now',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: HomeScreen.primaryPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== FAVORITE ARTISTS SECTION ====================
class _FavoriteArtistsSection extends StatelessWidget {
  const _FavoriteArtistsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Favorite Artists',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 96,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: artists.length >= 8 ? 8 : artists.length,
            itemBuilder: (context, index) {
              final artist = artists[index];
              return _ArtistAvatar(artist: artist);
            },
          ),
        ),
      ],
    );
  }
}

class _ArtistAvatar extends StatelessWidget {
  final Artist artist;

  const _ArtistAvatar({required this.artist});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ArtistDetailScreen(artist: artist)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            ClipOval(
              child: artist.image.isNotEmpty
                  ? Image.network(
                      artist.image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 60,
                        height: 60,
                        color: HomeScreen.cardColor,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white54,
                          size: 28,
                        ),
                      ),
                    )
                  : Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: HomeScreen.cardColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white54,
                        size: 28,
                      ),
                    ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 68,
              child: Text(
                artist.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== ALL SONGS SECTION ====================
class _AllSongsSection extends StatelessWidget {
  const _AllSongsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'All Songs',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${songs.length} tracks',
              style: const TextStyle(
                color: HomeScreen.textSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Consumer<FavoriteProvider>(
          builder: (context, favoriteProvider, child) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: songs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final song = songs[index];
                return _SongCard(song: song);
              },
            );
          },
        ),
      ],
    );
  }
}

class _SongCard extends StatelessWidget {
  final Song song;

  const _SongCard({required this.song});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFav = favoriteProvider.isFavorite(song.id);

    return Material(
      color: HomeScreen.cardColor,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: () {
          _navigateToSongDetail(context, song, playlistName: "All Songs");
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: song.image.isNotEmpty
              ? Image.network(
                  song.image,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 48,
                    height: 48,
                    color: Colors.white10,
                    child: const Icon(Icons.music_note, color: Colors.white54),
                  ),
                )
              : Container(
                  width: 48,
                  height: 48,
                  color: Colors.white10,
                  child: const Icon(Icons.music_note, color: Colors.white54),
                ),
        ),
        title: Text(
          song.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          song.artist,
          style: const TextStyle(color: HomeScreen.textSecondary, fontSize: 12),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              song.duration,
              style: const TextStyle(
                color: HomeScreen.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.redAccent : HomeScreen.textSecondary,
                size: 20,
              ),
              onPressed: () {
                favoriteProvider.toggleFavorite(song);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== MINI PLAYER WIDGET ====================
class _MiniPlayer extends StatelessWidget {
  const _MiniPlayer();

  @override
  Widget build(BuildContext context) {
    return Consumer2<PlayerProvider, FavoriteProvider>(
      builder: (context, playerProvider, favoriteProvider, child) {
        final currentSong =
            playerProvider.currentSong ??
            (songs.isNotEmpty ? songs.first : null);

        if (currentSong == null) return const SizedBox.shrink();

        final isFavorite = favoriteProvider.isFavorite(currentSong.id);

        return GestureDetector(
          onTap: () {
            _navigateToSongDetail(context, currentSong);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: HomeScreen.cardColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    currentSong.image,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 40,
                      height: 40,
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
                        currentSong.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        currentSong.artist,
                        style: const TextStyle(
                          color: HomeScreen.textSecondary,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.redAccent : Colors.white70,
                    size: 20,
                  ),
                  onPressed: () {
                    favoriteProvider.toggleFavorite(currentSong);
                  },
                ),
                CircleAvatar(
                  backgroundColor: HomeScreen.primaryPurple,
                  radius: 16,
                  child: IconButton(
                    icon: Icon(
                      playerProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 16,
                    ),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      playerProvider.togglePlayPause();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
