import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String _query = '';
  bool _isSearching = false;
  List<String> _searchResults = [];
  final List<String> _searchHistory = [];
  final List<String> _songs = []; // Populate with your audio IDs

  String get query => _query;
  bool get isSearching => _isSearching;
  List<String> get searchResults => _searchResults;
  List<String> get searchHistory => _searchHistory;

  void setSearchQuery(String query) {
    _query = query;
    _isSearching = query.isNotEmpty;
    _performSearch(query);
    notifyListeners();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      _searchResults = [];
      return;
    }

    // Perform search logic - you can replace this with your own search logic
    // For example, searching through audio files
    _searchResults = _songs
        .where((audio) => audio.toLowerCase().contains(query.toLowerCase()))
        .toList();

    // Add to history if query has results
    if (_searchResults.isNotEmpty && !_searchHistory.contains(query)) {
      _searchHistory.add(query);
    }
    notifyListeners();
  }

  void clearSearch() {
    _query = '';
    _isSearching = false;
    _searchResults = [];
    notifyListeners();
  }

  void addToHistory(String query) {
    if (!_searchHistory.contains(query) && query.isNotEmpty) {
      _searchHistory.add(query);
      notifyListeners();
    }
  }

  void clearHistory() {
    _searchHistory.clear();
    notifyListeners();
  }

  void removeFromHistory(String query) {
    _searchHistory.remove(query);
    notifyListeners();
  }

  // Add this method to set all audio IDs for searching
  void setAudioList(List<String> audioIds) {
    _songs.clear();
    _songs.addAll(audioIds);
    notifyListeners();
  }

  List<String> getRecentSearches() {
    final recent = _searchHistory.reversed.toList();
    return recent.length > 10 ? recent.sublist(0, 10) : recent;
  }
}