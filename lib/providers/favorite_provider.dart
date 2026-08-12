import 'package:flutter/material.dart';
import '../models/song.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Song> _favoriteSongs = [];

  List<Song> get favorites => _favoriteSongs;
  List<int> get favoriteIds => _favoriteSongs.map((song) => song.id).toList();

  bool isFavorite(int songId) {
    return _favoriteSongs.any((song) => song.id == songId);
  }

  Song? getFavoriteById(int songId) {
    try {
      return _favoriteSongs.firstWhere((song) => song.id == songId);
    } catch (e) {
      return null;
    }
  }

  void toggleFavorite(Song song) {
    if (isFavorite(song.id)) {
      _favoriteSongs.removeWhere((s) => s.id == song.id);
    } else {
      _favoriteSongs.add(song);
    }
    notifyListeners();
  }

  void addFavorite(Song song) {
    if (!isFavorite(song.id)) {
      _favoriteSongs.add(song);
      notifyListeners();
    }
  }

  void removeFavorite(int songId) {
    if (isFavorite(songId)) {
      _favoriteSongs.removeWhere((song) => song.id == songId);
      notifyListeners();
    }
  }

  void clearFavorites() {
    _favoriteSongs.clear();
    notifyListeners();
  }

  int get favoriteCount => _favoriteSongs.length;
}