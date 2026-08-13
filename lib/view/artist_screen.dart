// lib/screens/artist_screen.dart

import 'package:flutter/material.dart';
import '../models/artist.dart';
import '../data/mock_data.dart';
import 'artist_detail_screen.dart';

class ArtistScreen extends StatelessWidget {
  const ArtistScreen({super.key});

  // Theme constants matching your app design
  static const backgroundColor = Color(0xFF0C101A);
  static const cardColor = Color(0xFF181E2B);
  static const primaryPurple = Color(0xFF9D6BFF);
  static const textSecondary = Color(0xFF8F9BB3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text(
          'Artists',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header stats indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                '${artists.length} Artists Available',
                style: const TextStyle(
                  color: textSecondary,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Main Grid View of Artists
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                itemCount: artists.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.82,
                ),
                itemBuilder: (context, index) {
                  final artist = artists[index];
                  return _ArtistGridCard(artist: artist);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArtistGridCard extends StatelessWidget {
  final Artist artist;

  const _ArtistGridCard({required this.artist});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to ArtistDetailScreen when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArtistDetailScreen(artist: artist),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: ArtistScreen.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular Artist Avatar
            ClipOval(
              child: artist.image.isNotEmpty
                  ? Image.network(
                      artist.image,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 90,
                        height: 90,
                        color: Colors.white10,
                        child: const Icon(Icons.person, color: Colors.white54, size: 40),
                      ),
                    )
                  : Container(
                      width: 90,
                      height: 90,
                      color: Colors.white10,
                      child: const Icon(Icons.person, color: Colors.white54, size: 40),
                    ),
            ),
            const SizedBox(height: 12),

            // Artist Name
            Text(
              artist.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            // Subtitle / Genre Tag
            // Text(
            //   artist.genre ?? 'Artist',
            //   style: const TextStyle(
            //     color: ArtistScreen.textSecondary,
            //     fontSize: 12,
            //   ),
            //   textAlign: TextAlign.center,
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            // ),
          ],
        ),
      ),
    );
  }
}