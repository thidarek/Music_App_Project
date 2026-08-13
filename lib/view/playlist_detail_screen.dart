// lib/screens/song_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../models/song.dart';
import '../providers/player_provider.dart';
import '../providers/favorite_provider.dart';

class SongDetailScreen extends StatefulWidget {
  final Song song;
  final String playlistName;

  const SongDetailScreen({
    Key? key,
    required this.song,
    this.playlistName = "Now Playing",
  }) : super(key: key);

  @override
  State<SongDetailScreen> createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen> {
  YoutubePlayerController? _ytController;
  VideoPlayerController? _localVideoController;
  String? _localVideoError;
  bool _youtubeAvailable = true;
  bool _isRadioMode = false;

  @override
  void initState() {
    super.initState();
    if (_usesLocalVideo) {
      _initializeLocalVideo();
    } else {
      final videoId = _extractVideoId(widget.song.video);
      try {
        _ytController = YoutubePlayerController.fromVideoId(
          videoId: videoId,
          params: const YoutubePlayerParams(
            showControls: true,
            showFullscreenButton: true,
          ),
        );
      } catch (e) {
        // If WebView platform implementation is missing, fall back to external open
        _youtubeAvailable = false;
      }
    }

    // The screen can also be opened directly, so make sure its song starts.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final player = context.read<PlayerProvider>();
      if (!_usesLocalVideo && player.currentSong?.id != widget.song.id) {
        player.playSong(widget.song);
      }
    });
  }

  @override
  void dispose() {
    _ytController?.close();
    _localVideoController?.dispose();
    super.dispose();
  }

  String _extractVideoId(String urlOrId) {
    final uri = Uri.tryParse(urlOrId);
    if (uri == null) return urlOrId;
    if (uri.queryParameters.containsKey('v')) return uri.queryParameters['v']!;
    if (uri.pathSegments.isNotEmpty) return uri.pathSegments.last;
    return urlOrId;
  }

  bool get _usesLocalVideo => widget.song.video.startsWith('lib/audios/');

  Future<void> _initializeLocalVideo() async {
    try {
      final controller = VideoPlayerController.asset(widget.song.video);
      _localVideoController = controller;
      await controller.initialize();
      await controller.play();
      if (mounted) setState(() {});
    } catch (error) {
      if (mounted) {
        setState(() {
          _localVideoError = 'Unable to play this video: $error';
        });
      }
    }
  }

  Widget _localVideoPlayer() {
    final controller = _localVideoController;
    if (controller == null || !controller.value.isInitialized) {
      return Center(
        child: _localVideoError == null
            ? const CircularProgressIndicator(color: Color(0xFF9D6BFF))
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _localVideoError!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
      );
    }

    return GestureDetector(
      onTap: _toggleLocalVideo,
      child: Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      ),
    );
  }

  void _toggleLocalVideo() {
    final controller = _localVideoController;
    if (controller == null || !controller.value.isInitialized) return;
    setState(() {
      controller.value.isPlaying ? controller.pause() : controller.play();
    });
  }

  Widget _youtubeFallback(BuildContext context) {
    final hasVideo = widget.song.video.isNotEmpty;
    final image = widget.song.image;
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image.isNotEmpty)
            Expanded(
              child: Image.network(widget.song.image, fit: BoxFit.cover),
            )
          else
            const Expanded(
              child: Center(child: Icon(Icons.music_note, color: Colors.white54, size: 64)),
            ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: hasVideo ? _openInExternalBrowser : null,
            icon: const Icon(Icons.open_in_new),
            label: const Text('Open in YouTube'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF9D6BFF)),
          ),
        ],
      ),
    );
  }

  Future<void> _openInExternalBrowser() async {
    final url = widget.song.video;
    if (url.isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      // ignore - best effort
    }
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF0C101A);
    const primaryPurple = Color(0xFF9D6BFF);
    const cardBackgroundColor = Color(0xFF181E2B);

    final playerProvider = Provider.of<PlayerProvider>(context);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFavorite = favoriteProvider.isFavorite(widget.song.id);
    final localVideo = _localVideoController;
    final isLocalVideoReady = _usesLocalVideo &&
        localVideo != null &&
        localVideo.value.isInitialized;
    final currentPosition = isLocalVideoReady
        ? localVideo.value.position
        : playerProvider.currentPosition;
    final totalDuration = isLocalVideoReady
        ? localVideo.value.duration
        : playerProvider.totalDuration;
    final isPlaying = isLocalVideoReady
        ? localVideo.value.isPlaying
        : playerProvider.isPlaying;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              widget.playlistName.toUpperCase(),
              style: const TextStyle(
                color: Color(0xFF8F9BB3),
                fontSize: 11,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              widget.song.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            children: [
              const Spacer(),

              // Embedded YouTube Player with Glow Shadow
              Center(
                child: Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: primaryPurple.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 2,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: _usesLocalVideo
                        ? _localVideoPlayer()
                        : _youtubeAvailable
                        ? YoutubePlayer(
                            controller: _ytController!,
                          )
                        : _youtubeFallback(context),
                  ),
                ),
              ),

              const Spacer(),

              // Radio / Audio Mode Badge Toggle
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isRadioMode = !_isRadioMode;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _isRadioMode ? primaryPurple : cardBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _isRadioMode ? primaryPurple : Colors.white24,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _isRadioMode ? Icons.radio : Icons.graphic_eq,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _isRadioMode ? 'Live Radio Mode' : 'Standard Audio',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Title, Artist & Favorite Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.song.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.song.artist,
                          style: const TextStyle(
                            color: Color(0xFF8F9BB3),
                            fontSize: 15,
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
                      size: 28,
                    ),
                    onPressed: () {
                      favoriteProvider.toggleFavorite(widget.song);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Audio Slider Bar
              Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                      activeTrackColor: primaryPurple,
                      inactiveTrackColor: Colors.white12,
                      thumbColor: Colors.white,
                    ),
                    child: Slider(
                      value: currentPosition.inMilliseconds
                          .clamp(0, totalDuration.inMilliseconds)
                          .toDouble(),
                      min: 0.0,
                      max: totalDuration.inMilliseconds > 0
                          ? totalDuration.inMilliseconds.toDouble()
                          : 1.0,
                      onChanged: (double value) {
                        final position = Duration(milliseconds: value.round());
                        if (_usesLocalVideo) {
                          _localVideoController?.seekTo(position);
                        } else {
                          playerProvider.seekTo(position);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          playerProvider.formatTime(currentPosition),
                          style: const TextStyle(color: Color(0xFF8F9BB3), fontSize: 12),
                        ),
                        Text(
                          totalDuration == Duration.zero
                              ? widget.song.duration
                              : playerProvider.formatTime(totalDuration),
                          style: const TextStyle(color: Color(0xFF8F9BB3), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Playback Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.shuffle,
                      color: playerProvider.isShuffleEnabled
                          ? primaryPurple
                          : Colors.white38,
                    ),
                    onPressed: playerProvider.toggleShuffle,
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_previous, color: Colors.white, size: 32),
                    onPressed: playerProvider.hasPrevious
                        ? playerProvider.previousSong
                        : null,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_usesLocalVideo) {
                        _toggleLocalVideo();
                      } else if (playerProvider.currentSong?.id != widget.song.id) {
                        playerProvider.playSong(widget.song);
                      } else {
                        playerProvider.togglePlayPause();
                      }
                    },
                    child: Container(
                      height: 64,
                      width: 64,
                      decoration: const BoxDecoration(
                        color: primaryPurple,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: primaryPurple,
                            blurRadius: 15,
                            spreadRadius: -2,
                          ),
                        ],
                      ),
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next, color: Colors.white, size: 32),
                    onPressed: playerProvider.hasNext
                        ? playerProvider.nextSong
                        : null,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.repeat,
                      color: playerProvider.isRepeatEnabled
                          ? primaryPurple
                          : Colors.white38,
                    ),
                    onPressed: playerProvider.toggleRepeat,
                  ),
                ],
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
