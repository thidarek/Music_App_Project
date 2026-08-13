import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:music_app_project/providers/favorite_provider.dart';
import 'package:music_app_project/providers/player_provider.dart';
import 'package:music_app_project/view/playlist_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  static const Color _background = Color(0xFF0C101A);
  static const Color _cardSurface = Color(0xFF181E2B);
  static const Color _accentPurple = Color(0xFF8B7FE8);
  static const Color _textSecondary = Color(0xFF9CA3B5);

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoriteProvider>(context);
    final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    final favorites = favProvider.favorites;

    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: favorites.isEmpty
          ? _buildEmptyState()
          : CustomScrollView(
              slivers: [
                // Top Header Section: Total Count & Play All Button
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${favorites.length} ${favorites.length == 1 ? 'Song' : 'Songs'}',
                          style: const TextStyle(
                            color: _textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (favorites.isNotEmpty) {
                              playerProvider.playSong(favorites.first);
                            }
                          },
                          icon: const Icon(Icons.play_arrow_rounded, color: Colors.black),
                          label: const Text(
                            'Play All',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _accentPurple,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Favorites Song List
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final song = favorites[index];

                        // Swipe-to-dismiss for quick removal
                        return Dismissible(
                          key: Key(song.id.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) {
                            favProvider.removeFavorite(song.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${song.title} removed from favorites'),
                                duration: const Duration(seconds: 2),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    favProvider.addFavorite(song);
                                  },
                                ),
                              ),
                            );
                          },
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Material(
                              color: _cardSurface,
                              borderRadius: BorderRadius.circular(14),
                              clipBehavior: Clip.antiAlias,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                leading: Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white10,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: song.image.isNotEmpty
                                      ? Image.network(
                                          song.image,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => const Icon(
                                            Icons.music_note,
                                            color: Colors.white54,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.music_note,
                                          color: Colors.white54,
                                        ),
                                ),
                                title: Text(
                                  song.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                subtitle: Text(
                                  song.artist,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: _textSecondary,
                                    fontSize: 13,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () => favProvider.removeFavorite(song.id),
                                ),
                                onTap: () {
                                  playerProvider.playSong(song);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SongDetailScreen(
                                        song: song,
                                        playlistName: 'Favorites',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: favorites.length,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  /// Clean empty state placeholder
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _cardSurface,
            ),
            child: const Icon(
              Icons.favorite_border_rounded,
              size: 56,
              color: _textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No Favorite Songs Yet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Songs you mark as favorite will show up here.',
            style: TextStyle(
              color: _textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}