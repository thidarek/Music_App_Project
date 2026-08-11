import 'package:flutter/material.dart';
import '../model/artist.dart';
import '../model/song.dart';
import '../widget/custom_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B101D),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _TopAppBar(),
                  SizedBox(height: 16),
                  _FeaturedBanner(),
                  SizedBox(height: 24),
                  _RecentlyPlayedSection(),
                  SizedBox(height: 24),
                  _TrendingSongsSection(),
                  SizedBox(height: 24),
                  _FavoriteArtistsSection(),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const _MiniPlayer(),
                  CustomBottomNav(
                    currentIndex: _currentIndex,
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopAppBar extends StatelessWidget {
  const _TopAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=12',
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Good evening',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {        },
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedBanner extends StatelessWidget {
  const _FeaturedBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF2C1654), Color(0xFF140D2B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(20),
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
              'FEATURED PLAYLIST',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Midnight Moods',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB388FF),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            icon: const Icon(Icons.play_arrow_rounded, size: 20),
            label: const Text(
              'Play Now',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentlyPlayedSection extends StatelessWidget {
  const _RecentlyPlayedSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SectionHeader(title: 'Recently Played', onSeeAll: () {}),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 3,
            itemBuilder: (context, index) {
              final titles = ['Urban Escape', 'Synth Waves', 'Jazz Chill'];
              final subtitles = [
                'Various Artists',
                'Digital Mirage',
                'The Quartet',
              ];
              return Container(
                width: 120,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.music_note,
                          color: Colors.white54,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      titles[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      subtitles[index],
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TrendingSongsSection extends StatelessWidget {
  const _TrendingSongsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SectionHeader(title: 'Trending Songs', onSeeAll: () {}),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: songs.length > 3 ? 3 : songs.length,
          itemBuilder: (context, index) {
            final song = songs[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.music_note, color: Colors.white54),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          song.artist,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    song.duration,
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _FavoriteArtistsSection extends StatelessWidget {
  const _FavoriteArtistsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SectionHeader(title: 'Favorite Artists', onSeeAll: () {}),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: artists.length,
            itemBuilder: (context, index) {
              final artist = artists[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white10,
                      child: Text(
                        artist.name[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      artist.name,
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MiniPlayer extends StatelessWidget {
  const _MiniPlayer();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF192238),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.music_note, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Starboy',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  'The Weeknd',
                  style: TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {},
          ),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFB388FF),
            ),
            child: IconButton(
              icon: const Icon(Icons.pause, color: Colors.black, size: 18),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: onSeeAll,
            child: const Text(
              'View All',
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
