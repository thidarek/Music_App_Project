import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/song.dart';

class PlayerProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  // Current playing song
  Song? _currentSong;
  bool _isPlaying = false;
  bool _isLoading = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  double _volume = 1.0;
  bool _isMuted = false;
  List<Song> _queue = [];
  int _currentIndex = -1;
  bool _isRepeatEnabled = false;
  bool _isShuffleEnabled = false;

  // Getters
  AudioPlayer get audioPlayer => _audioPlayer;
  Song? get currentSong => _currentSong;
  String? get currentAudioId => _currentSong?.id.toString();
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  Duration get currentPosition => _currentPosition;
  Duration get totalDuration => _totalDuration;
  double get volume => _volume;
  bool get isMuted => _isMuted;
  List<Song> get queue => _queue;
  int get currentIndex => _currentIndex;
  bool get isRepeatEnabled => _isRepeatEnabled;
  bool get isShuffleEnabled => _isShuffleEnabled;
  bool get hasNext => _currentIndex < _queue.length - 1;
  bool get hasPrevious => _currentIndex > 0;

  PlayerProvider() {
    _setupAudioListeners();
  }

  void _setupAudioListeners() {
    // Update position
    _audioPlayer.onPositionChanged.listen((position) {
      _currentPosition = position;
      notifyListeners();
    });

    // Update duration
    _audioPlayer.onDurationChanged.listen((duration) {
      _totalDuration = duration;
      notifyListeners();
    });

    // Handle completion
    _audioPlayer.onPlayerComplete.listen((event) {
      _onSongComplete();
    });

    // Handle errors
    _audioPlayer.onLog.listen((log) {
      debugPrint('AudioPlayer Log: $log');
    });

    // _audioPlayer.onPlayerError.listen((error) {
    //   debugPrint('AudioPlayer Error: $error');
    //   _isLoading = false;
    //   notifyListeners();
    // });
  }

  // Play a song
  Future<void> playSong(Song song, {List<Song>? queue, int? index}) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Update queue if provided
      if (queue != null) {
        _queue = queue;
        _currentIndex = index ?? 0;
      } else if (!_queue.contains(song)) {
        // Add to queue if not already there
        _queue.add(song);
        _currentIndex = _queue.indexOf(song);
      } else {
        _currentIndex = _queue.indexOf(song);
      }

      // Update current song
      _currentSong = song;
      
      // You'll need to provide actual audio URLs
      // For demo, using a placeholder URL
      final String audioUrl = _getAudioUrl(song);
      
      await _audioPlayer.play(UrlSource(audioUrl));
      _isPlaying = true;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error playing song: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  // Pause audio
  Future<void> pauseAudio() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
        _isPlaying = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error pausing audio: $e');
    }
  }

  // Resume audio
  Future<void> resumeAudio() async {
    try {
      if (!_isPlaying && _currentSong != null) {
        await _audioPlayer.resume();
        _isPlaying = true;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error resuming audio: $e');
    }
  }

  // Toggle play/pause
  Future<void> togglePlayPause() async {
    if (_currentSong == null) return;
    
    if (_isPlaying) {
      await pauseAudio();
    } else {
      await resumeAudio();
    }
  }

  // Stop audio
  Future<void> stopAudio() async {
    try {
      await _audioPlayer.stop();
      _isPlaying = false;
      _currentPosition = Duration.zero;
      _currentSong = null;
      _queue.clear();
      _currentIndex = -1;
      notifyListeners();
    } catch (e) {
      debugPrint('Error stopping audio: $e');
    }
  }

  // Skip to next song
  Future<void> nextSong() async {
    if (_queue.isEmpty) return;
    
    if (_isRepeatEnabled && _currentIndex == _queue.length - 1) {
      // If repeat is enabled and at the end, go to first song
      await _playSongAtIndex(0);
    } else if (hasNext) {
      await _playSongAtIndex(_currentIndex + 1);
    }
  }

  // Skip to previous song
  Future<void> previousSong() async {
    if (_queue.isEmpty) return;
    
    // If current position > 2 seconds, restart song
    if (_currentPosition.inSeconds > 2) {
      await seekTo(Duration.zero);
      return;
    }
    
    if (hasPrevious) {
      await _playSongAtIndex(_currentIndex - 1);
    } else if (_isRepeatEnabled) {
      // If repeat is enabled and at the start, go to last song
      await _playSongAtIndex(_queue.length - 1);
    }
  }

  // Play song at specific index
  Future<void> _playSongAtIndex(int index) async {
    if (index < 0 || index >= _queue.length) return;
    
    final song = _queue[index];
    await playSong(song, queue: _queue, index: index);
  }

  // Seek to position
  Future<void> seekTo(Duration position) async {
    try {
      await _audioPlayer.seek(position);
      _currentPosition = position;
      notifyListeners();
    } catch (e) {
      debugPrint('Error seeking: $e');
    }
  }

  // Set volume
  Future<void> setVolume(double volume) async {
    try {
      _volume = volume.clamp(0.0, 1.0);
      await _audioPlayer.setVolume(_volume);
      notifyListeners();
    } catch (e) {
      debugPrint('Error setting volume: $e');
    }
  }

  // Toggle mute
  Future<void> toggleMute() async {
    _isMuted = !_isMuted;
    await _audioPlayer.setVolume(_isMuted ? 0.0 : _volume);
    notifyListeners();
  }

  // Toggle repeat
  void toggleRepeat() {
    _isRepeatEnabled = !_isRepeatEnabled;
    notifyListeners();
  }

  // Toggle shuffle
  void toggleShuffle() {
    _isShuffleEnabled = !_isShuffleEnabled;
    if (_isShuffleEnabled) {
      _shuffleQueue();
    }
    notifyListeners();
  }

  // Shuffle queue
  void _shuffleQueue() {
    if (_queue.length <= 1) return;
    
    final currentSong = _currentSong;
    _queue.shuffle();
    
    // Move current song to the front
    if (currentSong != null && _queue.contains(currentSong)) {
      _queue.remove(currentSong);
      _queue.insert(0, currentSong);
      _currentIndex = 0;
    }
  }

  // Set queue
  void setQueue(List<Song> queue, {int? startIndex}) {
    _queue = List.from(queue);
    _currentIndex = startIndex ?? 0;
    notifyListeners();
  }

  // Add to queue
  void addToQueue(Song song) {
    _queue.add(song);
    notifyListeners();
  }

  // Remove from queue
  void removeFromQueue(int index) {
    if (index < 0 || index >= _queue.length) return;
    
    if (index == _currentIndex) {
      // If removing current song, stop playback
      _audioPlayer.stop();
      _isPlaying = false;
      _currentSong = null;
      _currentPosition = Duration.zero;
    }
    
    _queue.removeAt(index);
    if (index < _currentIndex) {
      _currentIndex--;
    }
    notifyListeners();
  }

  // Clear queue
  void clearQueue() {
    _queue.clear();
    _currentIndex = -1;
    notifyListeners();
  }

  // Handle song completion
  void _onSongComplete() {
    _isPlaying = false;
    _currentPosition = Duration.zero;
    
    if (_isRepeatEnabled) {
      // Restart the same song
      if (_currentSong != null) {
        playSong(_currentSong!);
      }
    } else if (hasNext) {
      // Play next song
      nextSong();
    } else {
      // End of queue
      notifyListeners();
    }
  }

  // Get audio URL (you need to implement this based on your data)
  String _getAudioUrl(Song song) {
    // Option 1: Use API endpoint
    // return 'https://your-api.com/songs/${song.id}/stream';
    
    // Option 2: Use local assets
    // return 'assets/audio/${song.id}.mp3';
    
    // Option 3: Use network URL stored in song model
    // return song.audioUrl ?? '';
    
    // Option 4: Generate URL based on song ID
    return 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-${song.id}.mp3';
    
    // Note: Replace with your actual audio source
  }

  // Format duration to mm:ss
  String formatTime(Duration duration) {
    if (duration == Duration.zero) return '0:00';
    
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    
    if (duration.inHours > 0) {
      return '${duration.inHours}:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  // Get progress as percentage (0.0 to 1.0)
  double get progressPercentage {
    if (_totalDuration == Duration.zero) return 0.0;
    return _currentPosition.inSeconds / _totalDuration.inSeconds;
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}