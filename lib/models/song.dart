class Song {
  int id;
  String title;
  String artist;
  String image;
  String duration;
  bool isFavorite;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.image,
    required this.duration,
    this.isFavorite = false,
  });
}
