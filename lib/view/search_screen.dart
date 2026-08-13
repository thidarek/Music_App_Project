import 'package:flutter/material.dart';
import 'package:music_app_project/providers/search_provider.dart';
import 'package:music_app_project/data/mock_data.dart';
import 'package:music_app_project/providers/player_provider.dart';
import 'package:music_app_project/view/playlist_detail_screen.dart';
import 'package:provider/provider.dart';
// import 'search_provider.dart'; // Adjust import path if needed

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;

  static const Color _background = Color(0xFF0D1220);
  static const Color _cardSurface = Color(0xFF1A2033);
  static const Color _accentPurple = Color(0xFF8B7FE8);
  static const Color _textPrimary = Colors.white;
  static const Color _textSecondary = Color(0xFF9CA3B5);

  // Static fallback categories for browsing
  static const List<_CategoryData> _categories = [
    _CategoryData('Rock', [Color(0xFFE8533A), Color(0xFFE0873A)]),
    _CategoryData('Jazz', [Color(0xFFE0A93A), Color(0xFFE8C93A)]),
    _CategoryData('Pop', [Color(0xFFD84FC0), Color(0xFFB84FE8)]),
    _CategoryData('Lofi', [Color(0xFF4F6FE8), Color(0xFF6F4FE0)]),
  ];

  static const List<_SongData> _trendingSongs = [
    _SongData('Midnight City', 'Neon Echoes', '3:42'),
    _SongData('Fluorescence', 'Arcade Glitch', '4:15'),
    _SongData('Shadow Work', 'The Voids', '2:58'),
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<SearchProvider>();
      // Populate provider searchable list with song titles (and artist names)
      final audioIds = songs.map((s) => '${s.title} - ${s.artist}').toList();
      provider.setAudioList(audioIds);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();

    return Container(
      color: _background,
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHeader()),
                SliverToBoxAdapter(child: _buildSearchBar(context, searchProvider)),
                
                // Show dynamic search results if user is actively searching
                if (searchProvider.isSearching) ...[
                  SliverToBoxAdapter(child: _buildSearchResults(searchProvider)),
                ] else ...[
                  // Default discovery view when search field is empty
                  SliverToBoxAdapter(child: _buildRecentSearches(context, searchProvider)),
                  SliverToBoxAdapter(child: _buildBrowseCategories(searchProvider)),
                  SliverToBoxAdapter(child: _buildTrendingSongs(context)),
                ],

                const SliverToBoxAdapter(child: SizedBox(height: 140)),
              ],
            ),
            
            // Floating Mini Player
            Positioned(
              left: 16,
              right: 16,
              bottom: 12,
              child: _buildMiniPlayer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: _cardSurface,
            child: Icon(Icons.person, color: _textSecondary, size: 20),
          ),
          const SizedBox(width: 12),
          const Text(
            'Search',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const Icon(Icons.notifications_none, color: _accentPurple, size: 26),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, SearchProvider searchProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: _cardSurface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: _textSecondary, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: _textPrimary, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Artists, songs, or podcasts',
                  hintStyle: TextStyle(color: _textSecondary, fontSize: 14),
                  border: InputBorder.none,
                  isDense: true,
                ),
                onChanged: (value) {
                  searchProvider.setSearchQuery(value);
                },
              ),
            ),
            if (searchProvider.query.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _searchController.clear();
                  searchProvider.clearSearch();
                },
                child: const Icon(Icons.close, color: _textSecondary, size: 20),
              )
            else
              const Icon(Icons.mic_none, color: _accentPurple, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(SearchProvider searchProvider) {
    final results = searchProvider.searchResults;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Results (${results.length})',
            style: const TextStyle(
              color: _textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
              if (results.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Text(
                  'No matching songs found',
                  style: TextStyle(color: _textSecondary, fontSize: 14),
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final songTitle = results[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: InkWell(
                    onTap: () {
                      // Try to find matching Song by title or title - artist
                      final match = songs.firstWhere(
                        (s) => ('${s.title} - ${s.artist}').toLowerCase() == songTitle.toLowerCase() || s.title.toLowerCase() == songTitle.toLowerCase(),
                        orElse: () => songs.first,
                      );
                      // Play the song and open detail screen
                      context.read<PlayerProvider>().playSong(match);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SongDetailScreen(song: match, playlistName: 'Search')),
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: _cardSurface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.music_note, color: _accentPurple, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            songTitle,
                            style: const TextStyle(
                              color: _textPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(Icons.play_arrow_rounded, color: _textSecondary, size: 24),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildRecentSearches(BuildContext context, SearchProvider searchProvider) {
    final recentSearches = searchProvider.getRecentSearches();

    if (recentSearches.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Searches',
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => searchProvider.clearHistory(),
                child: const Text(
                  'CLEAR ALL',
                  style: TextStyle(
                    color: _accentPurple,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: recentSearches.map((term) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = term;
                  searchProvider.setSearchQuery(term);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: _cardSurface,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        term,
                        style: const TextStyle(
                          color: _textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => searchProvider.removeFromHistory(term),
                        child: const Icon(Icons.close, color: _textSecondary, size: 14),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBrowseCategories(SearchProvider searchProvider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Browse Categories',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              final category = _categories[index];
              return GestureDetector(
                onTap: () {
                  _searchController.text = category.name;
                  searchProvider.setSearchQuery(category.name);
                },
                child: _buildCategoryCard(category),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(_CategoryData category) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: category.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Text(
            category.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Positioned(
            right: -6,
            bottom: -10,
            child: Transform.rotate(
              angle: 0.35,
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.music_note,
                  color: Colors.white70,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingSongs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trending Songs',
            style: TextStyle(
              color: _textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ..._trendingSongs.map((song) => _buildSongRow(song)),
        ],
      ),
    );
  }

  Widget _buildSongRow(_SongData song) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _cardSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.album, color: _textSecondary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  song.artist,
                  style: const TextStyle(color: _textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            song.duration,
            style: const TextStyle(color: _textSecondary, fontSize: 12),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.more_vert, color: _textSecondary, size: 18),
        ],
      ),
    );
  }

  Widget _buildMiniPlayer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _cardSurface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.album, color: _textSecondary, size: 18),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Midnight City',
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Neon Echoes',
                      style: TextStyle(color: _textSecondary, fontSize: 11),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.cast_connected, color: _textSecondary, size: 20),
              const SizedBox(width: 14),
              const CircleAvatar(
                radius: 18,
                backgroundColor: _accentPurple,
                child: Icon(Icons.pause, color: Colors.white, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 0.35,
              minHeight: 3,
              backgroundColor: _background,
              valueColor: AlwaysStoppedAnimation(_accentPurple),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryData {
  final String name;
  final List<Color> gradientColors;
  const _CategoryData(this.name, this.gradientColors);
}

class _SongData {
  final String title;
  final String artist;
  final String duration;
  const _SongData(this.title, this.artist, this.duration);
}