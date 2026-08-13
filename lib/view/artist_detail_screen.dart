import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/artist.dart';
import '../data/mock_data.dart';
import '../providers/player_provider.dart';
import 'playlist_detail_screen.dart';

class ArtistDetailScreen extends StatelessWidget {
  final Artist artist;

  const ArtistDetailScreen({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    final artistSongs = songs.where((s) => s.artist == artist.name).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(artist.name),
      ),
      backgroundColor: const Color(0xFF0C101A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 56,
                  backgroundImage: artist.image.isNotEmpty ? NetworkImage(artist.image) : null,
                  backgroundColor: const Color(0xFF181E2B),
                  child: artist.image.isEmpty ? const Icon(Icons.person, size: 40) : null,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                artist.name,
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                artist.bio,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 20),
              const Text('Songs', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: artistSongs.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final song = artistSongs[index];
                  return ListTile(
                    tileColor: const Color(0xFF131B2E),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: song.image.isNotEmpty
                          ? Image.network(song.image, width: 44, height: 44, fit: BoxFit.cover)
                          : Container(width: 44, height: 44, color: Colors.white10, child: const Icon(Icons.music_note, color: Colors.white)),
                    ),
                    title: Text(song.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    subtitle: Text(song.duration, style: const TextStyle(color: Colors.white54)),
                    onTap: () {
                      Provider.of<PlayerProvider>(context, listen: false).playSong(song);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SongDetailScreen(song: song, playlistName: artist.name),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
