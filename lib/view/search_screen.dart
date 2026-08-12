import 'package:flutter/material.dart';
import '../controller/search_controller.dart';
import '../model/song.dart';
import '../model/artist.dart';

// TODO (PROVIDER): ប្រសិនបើអ្នកប្រើ Provider គ្រប់គ្រង UI State អ្នកអាចប្តូរទីនេះទៅជា ConsumerWidget ឬ StatelessWidget បាន
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Controller សម្រាប់កាន់ State បណ្តោះអាសន្នពេលរត់ UI
  final SearchPageController _controller = SearchPageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO (PROVIDER): ទីនេះជាកន្លែងទាញយក MusicProvider ឬ NavigationProvider
    // ឧទាហរណ៍៖ final musicProvider = Provider.of<MusicProvider>(context);

    final bool isSearching = _controller.textController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFF0B101D),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120), // ទុកចន្លោះសម្រាប់ MiniPlayer និង BottomNav
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildSearchBox(),
              const SizedBox(height: 24),

              if (isSearching)
                _buildSearchResults()
              else ...[
                if (_controller.recentSearches.isNotEmpty) _buildRecentSearches(),
                const SizedBox(height: 24),
                _buildArtistsList(),
                const SizedBox(height: 24),
                _buildTrendingSongs(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ១. Header Section
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white),
              ),
              SizedBox(width: 12),
              Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              // TODO (PROVIDER): ចុចទីនេះដើម្បីបើក Notification Screen ឬ Trigger Provider Event
            },
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // ២. Search Field Box
  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white10),
        ),
        child: TextField(
          controller: _controller.textController,
          onChanged: (query) {
            _controller.search(query, () => setState(() {}));
          },
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search songs, artists, playlists...',
            hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
            prefixIcon: const Icon(Icons.search, color: Colors.white38),
            suffixIcon: _controller.textController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.white38),
                    onPressed: () {
                      _controller.textController.clear();
                      _controller.search('', () => setState(() {}));
                    },
                  )
                : const Icon(Icons.mic, color: Colors.white54),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  // ៣. Recent Searches Tags
  Widget _buildRecentSearches() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Searches',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _controller.clearRecentSearches(() => setState(() {}));
                },
                child: const Text(
                  'CLEAR ALL',
                  style: TextStyle(
                    color: Color(0xFFB388FF),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _controller.recentSearches.map((searchTag) {
              return InkWell(
                onTap: () {
                  _controller.textController.text = searchTag;
                  _controller.search(searchTag, () => setState(() {}));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    searchTag,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ៤. Artists List Section
  Widget _buildArtistsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Popular Artists',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: artists.length,
            itemBuilder: (context, index) {
              final artist = artists[index];
              return InkWell(
                onTap: () {
                  // TODO (PROVIDER / NAVIGATION): ចុចលើ Artist ដើម្បីប្តូរទៅកាន់ Artist Detail Screen
                  // context.read<NavigationProvider>().navigateToArtist(artist);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white10,
                        backgroundImage: artist.image.isNotEmpty
                            ? AssetImage(artist.image)
                            : null,
                        child: artist.image.isEmpty
                            ? const Icon(Icons.person, color: Colors.white54)
                            : null,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        artist.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ៥. Trending Songs Section
  Widget _buildTrendingSongs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trending Songs',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: songs.length > 5 ? 5 : songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];
              return _buildSongTile(song);
            },
          ),
        ],
      ),
    );
  }

  // ៦. Search Results View
  Widget _buildSearchResults() {
    final hasResults = _controller.filteredSongs.isNotEmpty ||
        _controller.filteredArtists.isNotEmpty ||
        _controller.filteredPlaylists.isNotEmpty;

    if (!hasResults) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text(
            'No results found',
            style: TextStyle(color: Colors.white54, fontSize: 16),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_controller.filteredSongs.isNotEmpty) ...[
            const Text(
              'Songs',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ..._controller.filteredSongs.map((song) => _buildSongTile(song)),
            const SizedBox(height: 20),
          ],
          if (_controller.filteredArtists.isNotEmpty) ...[
            const Text(
              'Artists',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ..._controller.filteredArtists.map(
              (artist) => ListTile(
                onTap: () {
                  // TODO (PROVIDER): ចុចលើ Artist រួចប្រាប់ Provider ឱ្យផ្លាស់ប្តូរអេក្រង់
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.white10,
                  backgroundImage: artist.image.isNotEmpty
                      ? AssetImage(artist.image)
                      : null,
                  child: artist.image.isEmpty
                      ? const Icon(Icons.person, color: Colors.white54)
                      : null,
                ),
                title: Text(
                  artist.name,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  artist.bio,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ៧. Song Item Tile
  Widget _buildSongTile(Song song) {
    return InkWell(
      onTap: () {
        // TODO (PROVIDER): នៅពេលចុចលើបទចម្រៀង សូមហៅ MusicPlayerProvider ឱ្យ Play បទនេះ
        // context.read<MusicPlayerProvider>().playSong(song);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
                image: song.image.isNotEmpty
                    ? DecorationImage(
                        image: AssetImage(song.image),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: song.image.isEmpty
                  ? const Icon(Icons.music_note, color: Colors.white54)
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    song.artist,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              song.duration,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white54),
              onPressed: () {
                // TODO (PROVIDER): ចុចទីនេះដើម្បីបង្ហាញ BottomSheet / Options Menu
              },
            ),
          ],
        ),
      ),
    );
  }
}