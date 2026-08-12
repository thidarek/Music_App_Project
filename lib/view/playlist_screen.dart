import 'package:flutter/material.dart';
import 'package:music_app_project/data/mock_data.dart';


import '../models/playlist.dart';
import '../models/song.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  // Local state to keep track of selected playlist for detailed view
  int _selectedPlaylistIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: If using Provider to fetch playlists dynamically:
    // final playlistList = context.watch<PlaylistProvider>().playlists;
    // For now, we use your static `playlists` list directly:
   final List<Playlist> currentPlaylists = playlists; 
  final selectedPlaylist = currentPlaylists[_selectedPlaylistIndex];
    return Scaffold(
      backgroundColor: const Color(0xFF0B101D),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 140),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Bar Profile & Notification
              _buildTopAppBar(),
              const SizedBox(height: 24),

              // 2. Section Title & "Create New" Button
              _buildHeaderSection(context),
              const SizedBox(height: 16),

              // 3. Grid of Playlists Cards (Clickable)
              _buildPlaylistGrid(currentPlaylists),
              const SizedBox(height: 28),

              // 4. Detailed Featured View for Selected Playlist
              _buildFeaturedPlaylistCard(selectedPlaylist),
            ],
          ),
        ),
      ),
    );
  }

  // Header App Bar
  Widget _buildTopAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
            ),
            SizedBox(width: 10),
            Text(
              'Good evening',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none, color: Colors.white),
        )
      ],
    );
  }

  // Header "My Playlists" + "Create New" Button
  Widget _buildHeaderSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'YOUR LIBRARY',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'My Playlists',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        // Clickable Create New Button
        InkWell(
          onTap: () => _showCreatePlaylistDialog(context),
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFEC4899), Color(0xFF8B5CF6)],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFEC4899).withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: const [
                Icon(Icons.add, color: Colors.white, size: 18),
                SizedBox(width: 6),
                Text(
                  'Create New',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Playlist Grid
  Widget _buildPlaylistGrid(List<Playlist> playlistList) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: playlistList.length > 4 ? 4 : playlistList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final playlist = playlistList[index];
        final isSelected = _selectedPlaylistIndex == index;

        return GestureDetector(
          // Click playlist card to select & expand details below
          onTap: () {
            setState(() {
              _selectedPlaylistIndex = index;
            });
            // TODO: Optional Provider call:
            // context.read<PlaylistProvider>().selectPlaylist(playlist);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: isSelected
                        ? Border.all(color: const Color(0xFFEC4899), width: 2)
                        : null,
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=500'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                playlist.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                '${playlist.songs.length} Songs',
                style: const TextStyle(color: Colors.white38, fontSize: 11),
              ),
            ],
          ),
        );
      },
    );
  }

  // Expanded Playlist Detail Card
  Widget _buildFeaturedPlaylistCard(Playlist playlist) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF131B2E),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Image
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),

          // Featured Badge
          Row(
            children: const [
              Icon(Icons.verified, color: Color(0xFFEC4899), size: 14),
              SizedBox(width: 6),
              Text(
                'FEATURED PLAYLIST',
                style: TextStyle(
                  color: Color(0xFFEC4899),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Title
          Text(
            playlist.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),

          // Description
          const Text(
            'Curated sun-drenched anthems for your golden hour sessions. Updated weekly with the freshest hits.',
            style: TextStyle(color: Colors.white54, fontSize: 11, height: 1.4),
          ),
          const SizedBox(height: 16),

          // Action buttons (Play, Favorite, Options)
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xFFD8B4FE),
                child: IconButton(
                  icon: const Icon(Icons.play_arrow_rounded, color: Colors.black, size: 24),
                  onPressed: () {
                    // TODO: Call Provider to play whole playlist
                    // context.read<MusicController>().playPlaylist(playlist);
                  },
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border, color: Colors.white70),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz, color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // List of Songs inside the Selected Playlist Card
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: playlist.songs.length,
            itemBuilder: (context, index) {
              final song = playlist.songs[index];
              return _buildSongItem(song);
            },
          ),
        ],
      ),
    );
  }

  // Song Tile
  Widget _buildSongItem(Song song) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(10),
            image: song.image.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(song.image),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: song.image.isEmpty
              ? const Icon(Icons.music_note, color: Colors.white54)
              : null,
        ),
        title: Text(
          song.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        subtitle: Text(
          song.artist,
          style: const TextStyle(color: Colors.white54, fontSize: 11),
        ),
        trailing: Text(
          song.duration,
          style: const TextStyle(color: Colors.white54, fontSize: 11),
        ),
        onTap: () {
          // TODO: Play selected song via Provider
          // context.read<MusicController>().playSong(song);
        },
      ),
    );
  }

  // Create Playlist Dialog when "+ Create New" button is pressed
  void _showCreatePlaylistDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF192238),
        title: const Text('Create New Playlist', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Playlist name...',
            hintStyle: TextStyle(color: Colors.white38),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFB388FF)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB388FF),
            ),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                // TODO: Save to Provider state
                // context.read<PlaylistProvider>().addPlaylist(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Create', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}