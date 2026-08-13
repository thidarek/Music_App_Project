// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:music_app_project/models/playlist.dart';
import 'package:provider/provider.dart';
import '../providers/player_provider.dart';
import '../providers/favorite_provider.dart';
import '../providers/playlist_provider.dart';
import '../data/mock_data.dart';
import '../models/song.dart';
import '../models/artist.dart';
import '../widgets/top_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 227, 227),
      body: Column(
        children: [
          // Top Nav Bar
          const TopNavBar(onProfileTap: null),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Recently Played
                  const _RecentlyPlayedSection(),
                  const SizedBox(height: 24),
                  // Trending Songs
                  const _TrendingSection(),
                  const SizedBox(height: 24),
                  // Favorite Artists
                  const _FavoriteArtistsSection(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== RECENTLY PLAYED SECTION ====================
class _RecentlyPlayedSection extends StatelessWidget {
  const _RecentlyPlayedSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recently Played',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // TextButton(
            //   onPressed: () {},
            //   child: Text(
            //     'View All',
            //     style: TextStyle(
            //       color: Colors.purple[600],
            //       fontSize: 14,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: Consumer<PlaylistProvider>(
            builder: (context, playlistProvider, child) {
              final playlists = playlistProvider.playlists;
              if (playlists.isEmpty) {
                return const Center(
                  child: Text(
                    'No playlists available',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }

              final displayPlaylists = playlists.take(5).toList();

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: displayPlaylists.length,
                itemBuilder: (context, index) {
                  final playlist = displayPlaylists[index];
                  return _RecentlyPlayedCard(playlist: playlist);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RecentlyPlayedCard extends StatelessWidget {
  final Playlist playlist;

  const _RecentlyPlayedCard({required this.playlist});

  @override
  Widget build(BuildContext context) {
    final firstSong = playlist.songs.isNotEmpty ? playlist.songs.first : null;
    final imageUrl = firstSong?.image ?? '';

    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 140,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.music_note,
                        color: Colors.grey,
                        size: 48,
                      ),
                    ),
                  )
                : Container(
                    height: 140,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.music_note,
                      color: Colors.grey,
                      size: 48,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  playlist.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  playlist.songs.isNotEmpty
                      ? '${playlist.songs.length} songs'
                      : 'Empty playlist',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== TRENDING SONGS SECTION ====================
class _TrendingSection extends StatelessWidget {
  const _TrendingSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Trending Songs',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Consumer<FavoriteProvider>(
          builder: (context, favoriteProvider, child) {
            final trendingSongs = songs.take(5).toList();

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: trendingSongs.length,
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.grey, height: 1),
              itemBuilder: (context, index) {
                final song = trendingSongs[index];
                final isFavorite = favoriteProvider.isFavorite(song.id);

                return _TrendingSongItem(
                  song: song,
                  rank: index + 1,
                  isFavorite: isFavorite,
                  onFavoriteToggle: () {
                    favoriteProvider.toggleFavorite(song);
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _TrendingSongItem extends StatelessWidget {
  final Song song;
  final int rank;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const _TrendingSongItem({
    required this.song,
    required this.rank,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final playerProvider = Provider.of<PlayerProvider>(
          context,
          listen: false,
        );
        playerProvider.playSong(song);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 32,
              alignment: Alignment.center,
              child: Text(
                '$rank',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: song.image.isNotEmpty
                  ? Image.network(
                      song.image,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 48,
                        height: 48,
                        color: Colors.grey[300],
                        child: const Icon(Icons.music_note, color: Colors.grey),
                      ),
                    )
                  : Container(
                      width: 48,
                      height: 48,
                      color: Colors.grey[300],
                      child: const Icon(Icons.music_note, color: Colors.grey),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    song.artist,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Text(
              song.duration,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onFavoriteToggle,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey[600],
                size: 20,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
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
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: artists.take(8).length,
            itemBuilder: (context, index) {
              final artist = artists[index];
              return _ArtistChip(artist: artist);
            },
          ),
        ),
      ],
    );
  }
}

class _ArtistChip extends StatelessWidget {
  final Artist artist;

  const _ArtistChip({required this.artist});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.purple[400]!, width: 2),
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundImage: artist.image.isNotEmpty
                  ? AssetImage(artist.image) as ImageProvider
                  : const AssetImage('assets/images/default_artist.jpg'),
              onBackgroundImageError: (_, __) {},
              backgroundColor: Colors.grey[200],
              child: artist.image.isEmpty
                  ? const Icon(Icons.person, color: Colors.grey, size: 28)
                  : null,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 60,
            child: Text(
              artist.name,
              style: const TextStyle(
                color: Colors.black,
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
    );
  }
}
