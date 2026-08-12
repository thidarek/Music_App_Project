import 'package:flutter/material.dart';



/// This file uses hardcoded mock data (see the lists/maps below) so the
/// layout can be reviewed and merged before the real data layer is ready.
/// Every place that should eventually read from a Provider is marked with
/// a `// PROVIDER:` comment — search for that tag to find all the spots
/// that need wiring once search_provider.dart / player_provider.dart are
/// ready to plug in.
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  // ---------------------------------------------------------------------
  // MOCK DATA — replace with real data via providers (see PROVIDER tags).
  // ---------------------------------------------------------------------

  // PROVIDER: replace with `context.watch<SearchProvider>().recentSearches`
  static const List<String> _recentSearches = [
    'Arctic Monkeys',
    'Lofi Beats',
    'Interstellar OST',
    'Billie Eilish',
    'Jazz Fusion',
  ];

  // PROVIDER: categories could come from a provider too if they're
  // data-driven later; for now they're static design content.
  static const List<_CategoryData> _categories = [
    _CategoryData('Rock', [Color(0xFFE8533A), Color(0xFFE0873A)]),
    _CategoryData('Jazz', [Color(0xFFE0A93A), Color(0xFFE8C93A)]),
    _CategoryData('Pop', [Color(0xFFD84FC0), Color(0xFFB84FE8)]),
    _CategoryData('Lofi', [Color(0xFF4F6FE8), Color(0xFF6F4FE0)]),
  ];

  // PROVIDER: replace with `context.watch<SearchProvider>().trendingSongs`
  // or a dedicated HomeProvider, depending on where "trending" logic lives.
  static const List<_SongData> _trendingSongs = [
    _SongData('Midnight City', 'Neon Echoes', '3:42'),
    _SongData('Fluorescence', 'Arcade Glitch', '4:15'),
    _SongData('Shadow Work', 'The Voids', '2:58'),
  ];

  // PROVIDER: replace with `context.watch<PlayerProvider>()` — currentSong,
  // isPlaying, and progress (0.0–1.0) would all come from there instead of
  // being hardcoded like this.
  static const String _nowPlayingTitle = 'Midnight City';
  static const String _nowPlayingArtist = 'Neon Echoes';
  static const double _nowPlayingProgress = 0.35;

  static const Color _background = Color(0xFF0D1220);
  static const Color _cardSurface = Color(0xFF1A2033);
  static const Color _accentPurple = Color(0xFF8B7FE8);
  static const Color _textPrimary = Colors.white;
  static const Color _textSecondary = Color(0xFF9CA3B5);

  @override
  Widget build(BuildContext context) {
    // IMPORTANT: no Scaffold and no bottomNavigationBar here.
    // This screen lives inside CustomBottomNav's IndexedStack, which
    // already owns the single Scaffold + bottom nav bar for the whole
    // app. Adding a second Scaffold/nav bar at this level is what was
    // producing the doubled nav bar and the squeezed mini player in the
    // screenshot — every tab must return plain content, not its own
    // Scaffold shell.
    return Container(
      color: _background,
      child: SafeArea(
        // Don't apply bottom safe-area padding here — CustomBottomNav's
        // own SafeArea around the nav bar already accounts for it, and
        // doing it twice pushes content up unnecessarily.
        bottom: false,
        child: Stack(
          children: [
            // Main scrollable content: header, search bar, sections.
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHeader()),
                SliverToBoxAdapter(child: _buildSearchBar()),
                SliverToBoxAdapter(child: _buildRecentSearches()),
                SliverToBoxAdapter(child: _buildBrowseCategories()),
                SliverToBoxAdapter(child: _buildTrendingSongs(context)),
                // Extra bottom padding so the last song isn't hidden
                // behind the floating mini player or the outer nav bar.
                const SliverToBoxAdapter(child: SizedBox(height: 140)),
              ],
            ),
            // Floating mini player, pinned near the bottom of the screen,
            // sitting above the scroll content. Consider hoisting this up
            // to CustomBottomNav instead (see note below _buildMiniPlayer)
            // so it persists across tabs rather than living inside Search
            // only.
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

  /// Top row: user/album avatar, screen title, notification bell.
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          // Small circular thumbnail (e.g. current playlist/album art).
          const CircleAvatar(
            radius: 20,
            backgroundColor: _cardSurface,
            // PROVIDER: swap for a NetworkImage/AssetImage once real
            // artwork is available.
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
          Icon(Icons.notifications_none, color: _accentPurple, size: 26),
        ],
      ),
    );
  }

  /// Rounded search input with a leading search icon and trailing mic icon.
  /// UI only — no controller/onChanged wired up here on purpose.
  Widget _buildSearchBar() {
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
            const Expanded(
              // PROVIDER: replace with a real TextField bound to
              // SearchProvider.search() once logic is wired up.
              child: Text(
                'Artists, songs, or podcasts',
                style: TextStyle(color: _textSecondary, fontSize: 14),
              ),
            ),
            const Icon(Icons.mic_none, color: _accentPurple, size: 22),
          ],
        ),
      ),
    );
  }

  /// "Recent Searches" title + clear-all action, then a wrap of pill chips.
  Widget _buildRecentSearches() {
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
              // PROVIDER: onTap -> context.read<SearchProvider>().clearRecentSearches()
              const Text(
                'CLEAR ALL',
                style: TextStyle(
                  color: _accentPurple,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Wrap lets chips flow onto multiple rows, matching the design.
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _recentSearches.map((term) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: _cardSurface,
                  borderRadius: BorderRadius.circular(24),
                ),
                // PROVIDER: wrap in GestureDetector -> re-run
                // SearchProvider.search(term) on tap.
                child: Text(
                  term,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// "Browse Categories" title + 2x2 grid of gradient cards.
  Widget _buildBrowseCategories() {
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
              return _buildCategoryCard(category);
            },
          ),
        ],
      ),
    );
  }

  /// Single gradient category card with the genre name in the top-left
  /// and a small rotated "cover art" square in the bottom-right corner.
  Widget _buildCategoryCard(_CategoryData category) {
    return Container(
      // PROVIDER: onTap -> navigate to a filtered results view / call
      // SearchProvider.search(category.name).
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
          // Decorative rotated square standing in for cover art.
          // PROVIDER: swap the icon for a real album image once artwork
          // per category/genre is available.
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

  /// "Trending Songs" title + vertical list of song rows.
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
          // PROVIDER: replace this static map() with a ListView.builder
          // over `context.watch<SearchProvider>().trendingSongs`.
          ..._trendingSongs.map((song) => _buildSongRow(song)),
          
        ],
      ),
    );
  }

  /// Single trending-song row: artwork placeholder, title/artist, duration,
  /// and an overflow menu.
  Widget _buildSongRow(_SongData song) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // PROVIDER: swap for real artwork (song.imageUrl) once song
          // model data is passed in instead of mock strings.
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
          // PROVIDER: onPressed -> show a menu with "Add to playlist",
          // "Favorite", etc., calling PlaylistProvider / FavoriteProvider.
          const Icon(Icons.more_vert, color: _textSecondary, size: 18),
        ],
      ),
    );
  }

  /// Floating mini player: artwork, title/artist, cast icon, play/pause,
  /// and a thin progress bar along the bottom edge.
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
              // PROVIDER: swap for the actual now-playing artwork.
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PROVIDER: context.watch<PlayerProvider>().currentSong.title
                    const Text(
                      _nowPlayingTitle,
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      _nowPlayingArtist,
                      style: TextStyle(color: _textSecondary, fontSize: 11),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.cast_connected, color: _textSecondary, size: 20),
              const SizedBox(width: 14),
              // PROVIDER: onTap -> context.read<PlayerProvider>().togglePlayPause()
              CircleAvatar(
                radius: 18,
                backgroundColor: _accentPurple,
                child: const Icon(Icons.pause, color: Colors.white, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Thin progress bar showing playback position.
          // PROVIDER: value should come from PlayerProvider's current
          // position / total duration.
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: _nowPlayingProgress,
              minHeight: 3,
              backgroundColor: _background,
              valueColor: const AlwaysStoppedAnimation(_accentPurple),
            ),
          ),
        ],
      ),
    );
  }

  // Bottom nav intentionally removed from this file — CustomBottomNav
  // (the widget you pasted) is the single source of truth for navigation
  // and already renders it once for every tab via IndexedStack.
}

/// Simple data holder for a browse-category card (UI mock only).
/// Replace with your real Category/Genre model if one exists.
class _CategoryData {
  final String name;
  final List<Color> gradientColors;
  const _CategoryData(this.name, this.gradientColors);
}

/// Simple data holder for a trending song row (UI mock only).
/// Replace with your real `Song` model from models/song.dart.
class _SongData {
  final String title;
  final String artist;
  final String duration;
  const _SongData(this.title, this.artist, this.duration);
}