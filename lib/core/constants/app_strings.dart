class AppStrings {
  // ============ GENERAL ============
  static  String appName = 'Music App';
  static  String goodEvening = 'Good evening';
  static  String goodMorning = 'Good morning';
  static  String goodAfternoon = 'Good afternoon';
  static  String goodNight = 'Good night';

  // ======= HOME SCREEN ============

  static  String playNow = 'Play Now';
  static  String recentlyPlayed = 'Recently Played';
  static  String viewAll = 'View All';
  static  String trendingSongs = 'Trending Songs';
  static  String favoriteArtists = 'Favorite Artists';


  // ======= PLAYER SCREEN ============
  static  String enjoyWithYourMusic = 'ENJOY WITH YOUR MUSIC';
  static  String share = 'SHARE';
  static  String save = 'SAVE';
  static  String upNext = 'UP NEXT';

  // ======= SEARCH SCREEN ============
  static  String search = 'Search';
  static  String searchHint = 'Artists, songs, or podcasts';
  static  String recentSearches = 'Recent Searches';
  static  String clearAll = 'CLEAR ALL';
  static  String browseCategories = 'Browse Categories';

  // ======= LIBRARY SCREEN ============
  static  String library = 'Library';
  static  String searchLibraryHint = 'Search your library';
  static  String favoriteSongs = 'Favorite Songs';
  static  String tracks = 'tracks';
  static  String artists = 'Artists';

  // ======= BOTTOM NAVIGATION ============
  static  String navHome = 'Home';
  static  String navSearch = 'Search';
  static  String navLibrary = 'Library';
  static  String navPlaylist = 'Playlist';
  static  String navProfile = 'Profile';
  
  // ============ TIME FORMATS ============
  static String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
  
  // ============ PLACEHOLDER TEXT ============
  static  String noResults = 'No results found';
  static  String tryAgain = 'Try again';
  static  String loading = 'Loading...';
  static  String error = 'Something went wrong';
  static  String retry = 'Retry';

  // ======= BUTTONS & ACTIONS ============
  static  String play = 'Play';
  static  String pause = 'Pause';
  static  String next = 'Next';
  static  String previous = 'Previous';
  static  String shuffle = 'Shuffle';
  static  String repeat = 'Repeat';
  static  String like = 'Like';
  static  String unlike = 'Unlike';
  static  String addToPlaylist = 'Add to Playlist';
  static  String removeFromPlaylist = 'Remove from Playlist';
  
  // ============ LIBRARY STATS ============
  static String favoriteTracksCount(int count) => '$count tracks';
  static String followingCount(int count) => 'Following $count artists';
  static String songsCount(int count) => 'Playlist: $count songs';
  
  // ======= PLAYER STATUS ============
  static  String nowPlaying = 'Now Playing';
  static  String fromAlbum = 'From Album';
}