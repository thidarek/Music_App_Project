class Song {
  int id;
  String title;
  String artist;
  String image;
  String video;
  String duration;
  bool isFavorite;
  

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.image,
    required this.video,
    required this.duration,
    this.isFavorite = false,
  });
}
