import 'package:music_app_project/models/song.dart';

class Playlist {
  int id;
  String name;
  List<Song> songs;

  Playlist({required this.id, required this.name, required this.songs});
}

