import 'package:flutter/material.dart';
import 'package:music_app_project/model/artist.dart';
import 'package:music_app_project/model/playlist.dart';
import 'package:music_app_project/model/song.dart';

class MusicController extends ChangeNotifier {
  // Retrieve data from model 
  final List<Song> _allSongs = songs;
  final List<Playlist> _allPlaylists = playlists;
  final List<Artist> _allArtists = artists;

  Song? _currentSong;
  bool _isPlaying = false;

  MusicController() {
    if (_allSongs.isNotEmpty) {
      _currentSong = _allSongs[0];
    }
  }

  // Getters
  List<Song> get allSongs => _allSongs;
  List<Playlist> get playlistsList => _allPlaylists;
  List<Artist> get artistsList => _allArtists;
  
  // retriver only Favorite Songs
  List<Song> get favoriteSongs => _allSongs.where((s) => s.isFavorite).toList();

  Song? get currentSong => _currentSong;
  bool get isPlaying => _isPlaying;

  // Actions
  void toggleFavorite(Song song) {
    song.isFavorite = !song.isFavorite;
    notifyListeners();
  }

  void playSong(Song song) {
    _currentSong = song;
    _isPlaying = true;
    notifyListeners();
  }

  void togglePlayPause() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }
}