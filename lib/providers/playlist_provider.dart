import 'package:flutter/material.dart';
import '../models/song.dart';
import '../models/playlist.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Playlist> _playlists = [];

  List<Playlist> get playlists => _playlists;
  
  // Get playlist by ID
  Playlist? getPlaylistById(String id) {
    try {
      return _playlists.firstWhere((playlist) => playlist.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get songs from a playlist
  List<Song> getPlaylistSongs(String playlistId) {
    final playlist = getPlaylistById(playlistId);
    return playlist?.songs ?? [];
  }

  // Get song IDs from a playlist
  List<int> getPlaylistSongIds(String playlistId) {
    final playlist = getPlaylistById(playlistId);
    return playlist?.songs.map((song) => song.id).toList() ?? [];
  }

  // Create a new playlist
  void createPlaylist(String name, {String? description, List<Song>? initialSongs}) {
    final playlist = Playlist(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      songs: initialSongs ?? [],
    );
    _playlists.add(playlist);
    notifyListeners();
  }

  // Delete a playlist
  void deletePlaylist(String playlistId) {
    _playlists.removeWhere((playlist) => playlist.id == playlistId);
    notifyListeners();
  }

  // Rename a playlist
  void renamePlaylist(String playlistId, String newName) {
    final index = _playlists.indexWhere((p) => p.id == playlistId);
    if (index != -1) {
      final playlist = _playlists[index];
      _playlists[index] = Playlist(
        id: playlist.id,
        name: newName,
        songs: playlist.songs,
      );
      notifyListeners();
    }
  }

  // Add song to playlist
  void addSongToPlaylist(String playlistId, Song song) {
    final index = _playlists.indexWhere((p) => p.id == playlistId);
    if (index != -1) {
      final playlist = _playlists[index];
      if (!playlist.songs.any((s) => s.id == song.id)) {
        final updatedSongs = List<Song>.from(playlist.songs)..add(song);
        _playlists[index] = Playlist(
          id: playlist.id,
          name: playlist.name,
          songs: updatedSongs,
        );
        notifyListeners();
      }
    }
  }

  // Add multiple songs to playlist
  void addSongsToPlaylist(String playlistId, List<Song> songs) {
    final index = _playlists.indexWhere((p) => p.id == playlistId);
    if (index != -1) {
      final playlist = _playlists[index];
      final existingIds = playlist.songs.map((s) => s.id).toSet();
      final newSongs = songs.where((s) => !existingIds.contains(s.id)).toList();
      
      if (newSongs.isNotEmpty) {
        final updatedSongs = List<Song>.from(playlist.songs)..addAll(newSongs);
        _playlists[index] = Playlist(
          id: playlist.id,
          name: playlist.name,
          songs: updatedSongs,
        );
        notifyListeners();
      }
    }
  }

  // Remove song from playlist
  void removeSongFromPlaylist(String playlistId, int songId) {
    final index = _playlists.indexWhere((p) => p.id == playlistId);
    if (index != -1) {
      final playlist = _playlists[index];
      final updatedSongs = playlist.songs.where((s) => s.id != songId).toList();
      _playlists[index] = Playlist(
        id: playlist.id,
        name: playlist.name,
        songs: updatedSongs,
      );
      notifyListeners();
    }
  }

  // Remove multiple songs from playlist
  void removeSongsFromPlaylist(String playlistId, List<int> songIds) {
    final index = _playlists.indexWhere((p) => p.id == playlistId);
    if (index != -1) {
      final playlist = _playlists[index];
      final songIdSet = songIds.toSet();
      final updatedSongs = playlist.songs.where((s) => !songIdSet.contains(s.id)).toList();
      _playlists[index] = Playlist(
        id: playlist.id,
        name: playlist.name,
        songs: updatedSongs,
      );
      notifyListeners();
    }
  }

  // Check if song is in playlist
  bool isSongInPlaylist(String playlistId, int songId) {
    final playlist = getPlaylistById(playlistId);
    return playlist?.songs.any((s) => s.id == songId) ?? false;
  }

  // Clear all songs from playlist
  void clearPlaylist(String playlistId) {
    final index = _playlists.indexWhere((p) => p.id == playlistId);
    if (index != -1) {
      final playlist = _playlists[index];
      _playlists[index] = Playlist(
        id: playlist.id,
        name: playlist.name,
        songs: [],
      );
      notifyListeners();
    }
  }

  // Get playlist song count
  int getPlaylistSongCount(String playlistId) {
    final playlist = getPlaylistById(playlistId);
    return playlist?.songs.length ?? 0;
  }

  // Move song to different position in playlist
  void reorderSongs(String playlistId, int oldIndex, int newIndex) {
    final index = _playlists.indexWhere((p) => p.id == playlistId);
    if (index != -1) {
      final playlist = _playlists[index];
      final songs = List<Song>.from(playlist.songs);
      
      if (oldIndex >= 0 && oldIndex < songs.length && 
          newIndex >= 0 && newIndex < songs.length) {
        final song = songs.removeAt(oldIndex);
        songs.insert(newIndex, song);
        
        _playlists[index] = Playlist(
          id: playlist.id,
          name: playlist.name,
          songs: songs,
        );
        notifyListeners();
      }
    }
  }

  // Create a copy of a playlist
  void duplicatePlaylist(String playlistId, String newName) {
    final playlist = getPlaylistById(playlistId);
    if (playlist != null) {
      final newPlaylist = Playlist(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: newName,
        songs: List<Song>.from(playlist.songs),
      );
      _playlists.add(newPlaylist);
      notifyListeners();
    }
  }

  // Search playlists by name
  List<Playlist> searchPlaylists(String query) {
    if (query.isEmpty) return _playlists;
    final lowerQuery = query.toLowerCase();
    return _playlists.where((playlist) => 
      playlist.name.toLowerCase().contains(lowerQuery)
    ).toList();
  }

  // Initialize with data from mock_data.dart
  void initializePlaylists(List<Playlist> initialPlaylists) {
    _playlists.clear();
    _playlists.addAll(initialPlaylists);
    notifyListeners();
  }

  // Clear all playlists
  void clearAllPlaylists() {
    _playlists.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}