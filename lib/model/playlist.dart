import 'package:music_app_project/model/song.dart';

class Playlist {
  int id;
  String name;
  List<Song> songs;

  Playlist({required this.id, required this.name, required this.songs});
}

List<Playlist> playlists = [
  Playlist(id: 1, name: "Top Hits", songs: songs.sublist(0, 5)),
  Playlist(id: 2, name: "Workout Mix", songs: songs.sublist(5, 10)),
  Playlist(id: 3, name: "Chill Vibes", songs: songs.sublist(10, 15)),
  Playlist(id: 4, name: "Romantic Songs", songs: songs.sublist(15, 20)),
  Playlist(
    id: 5,
    name: "Morning Boost",
    songs: [songs[0], songs[3], songs[7], songs[12], songs[18]],
  ),
  Playlist(
    id: 6,
    name: "Late Night",
    songs: [songs[1], songs[4], songs[8], songs[11], songs[17]],
  ),
  Playlist(
    id: 7,
    name: "Road Trip",
    songs: [songs[2], songs[5], songs[9], songs[13], songs[19]],
  ),
  Playlist(
    id: 8,
    name: "Acoustic Favorites",

    songs: [songs[0], songs[5], songs[10], songs[15], songs[18]],
  ),
  Playlist(
    id: 9,
    name: "Party Time",
    songs: [songs[2], songs[6], songs[8], songs[14], songs[16]],
  ),
  Playlist(
    id: 10,
    name: "Relax & Study",
    songs: [songs[1], songs[4], songs[9], songs[12], songs[19]],
  ),
  Playlist(
    id: 10,
    name: "ENHYPEN Collection",
    songs: [songs[21], songs[22], songs[23], songs[24], songs[25]],
  ),
];
