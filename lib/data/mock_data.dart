
import 'package:music_app_project/models/artist.dart';
import 'package:music_app_project/models/playlist.dart';
import 'package:music_app_project/models/song.dart';

//Artist
List<Artist> artists = [
  Artist(
    id: 1,
    name: "The Weeknd",
    image: "assets/images/artists/the_weeknd.jpg",
    bio: "Canadian singer known for R&B, pop, and synthwave music.",
  ),
  Artist(
    id: 2,
    name: "Ed Sheeran",
    image: "assets/images/artists/ed_sheeran.jpg",
    bio: "English singer-songwriter famous for acoustic pop hits.",
  ),
  Artist(
    id: 3,
    name: "Taylor Swift",
    image: "assets/images/artists/taylor_swift.jpg",
    bio: "American singer-songwriter known for country and pop music.",
  ),
  Artist(
    id: 4,
    name: "Billie Eilish",
    image: "assets/images/artists/billie_eilish.jpg",
    bio: "Grammy-winning artist recognized for her unique alternative pop style.",
  ),
  Artist(
    id: 5,
    name: "Imagine Dragons",
    image: "assets/images/artists/imagine_dragons.jpg",
    bio: "American pop rock band best known for energetic anthems.",
  ),
  Artist(
    id: 6,
    name: "Dua Lipa",
    image: "assets/images/artists/dua_lipa.jpg",
    bio: "British-Albanian pop singer with multiple chart-topping songs.",
  ),
  Artist(
    id: 7,
    name: "Justin Bieber",
    image: "assets/images/artists/justin_bieber.jpg",
    bio: "Canadian pop singer with numerous international hits.",
  ),
  Artist(
    id: 8,
    name: "Adele",
    image: "assets/images/artists/adele.jpg",
    bio: "British singer celebrated for her soulful voice and emotional ballads.",
  ),
  Artist(
    id: 9,
    name: "Bruno Mars",
    image: "assets/images/artists/bruno_mars.jpg",
    bio: "American singer-songwriter blending pop, funk, soul, and R&B.",
  ),
  Artist(
    id: 10,
    name: "Maroon 5",
    image: "assets/images/artists/maroon5.jpg",
    bio: "American pop rock band led by vocalist Adam Levine.",
  ),
  Artist(
  id: 11,
  name: "ENHYPEN",
  image: "assets/images/artists/enhypen.jpg",
  bio: "South Korean boy group formed through the survival show I-LAND, known for songs like Bite Me, FEVER, Drunk-Dazed, and Sweet Venom.",
),
];

// Song
List<Song> songs = [
  Song(
    id: 1,
    title: "Blinding Lights",
    artist: "The Weeknd",
    image:
        "https://upload.wikimedia.org/wikipedia/en/e/e6/The_Weeknd_-_Blinding_Lights.png",
    duration: "3:20",
  ),
  Song(
    id: 2,
    title: "Shape of You",
    artist: "Ed Sheeran",
    image:
        "https://m.media-amazon.com/images/M/MV5BMGNlODRhYjEtMTY3ZC00Y2QwLTk0Y2ItNDE0NDUyYmQxYWQ4XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
    duration: "3:53",
  ),
  Song(
    id: 3,
    title: "Levitating",
    artist: "Dua Lipa",
    image:
        "https://i1.sndcdn.com/artworks-orxd3Qu4MvUnj9Wp-zpTayQ-t500x500.jpg",
    duration: "3:24",
  ),
  Song(
    id: 4,
    title: "Someone Like You",
    artist: "Adele",
    image:
        "https://upload.wikimedia.org/wikipedia/en/7/7a/Adele_-_Someone_Like_You.png",
    duration: "4:45",
  ),
  Song(
    id: 5,
    title: "Perfect",
    artist: "Ed Sheeran",
    image:
        "https://upload.wikimedia.org/wikipedia/en/8/80/Ed_Sheeran_Perfect_Single_cover.jpg",
    duration: "4:23",
  ),
  Song(
    id: 6,
    title: "Stay",
    artist: "The Kid LAROI & Justin Bieber",
    image: "https://i.scdn.co/image/ab67616d0000b273aed1660585c1e3c9ffb50b6a",
    duration: "2:21",
  ),
  Song(
    id: 7,
    title: "Bad Guy",
    artist: "Billie Eilish",
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPlgd3LTQBpmHx8V_VJFgNlLwYQDNQe52Gu5D7NfGbczcMrl4RLHak-Bw&s=10",
    duration: "3:14",
  ),
  Song(
    id: 8,
    title: "Believer",
    artist: "Imagine Dragons",
    image: "https://i.scdn.co/image/ab67616d0000b2735675e83f707f1d7271e5cf8a",
    duration: "3:24",
  ),
  Song(
    id: 9,
    title: "Senorita",
    artist: "Shawn Mendes & Camila Cabello",
    image:
        "https://i1.sndcdn.com/artworks-HAZ3Ru34GTQ3rAmd-LVwITA-t500x500.jpg",
    duration: "3:11",
  ),
  Song(
    id: 10,
    title: "Peaches",
    artist: "Justin Bieber",
    image:
        "https://i1.sndcdn.com/artworks-eb0MriwCeIEzf4mo-bUQc2A-t500x500.jpg",
    duration: "3:18",
  ),
  Song(
    id: 11,
    title: "Flowers",
    artist: "Miley Cyrus",
    image:
        "https://m.media-amazon.com/images/M/MV5BYzU3ZTFkZDctYmNlNi00ZjMxLTgwNGItYTI1YjdmOWJiNTQzXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
    duration: "3:20",
  ),
  Song(
    id: 12,
    title: "ស្ទឹងសែនប៉ារីស",
    artist: "សូ សាវឿន",
    image:
        "https://i.ytimg.com/vi/fQtH9_dC5yc/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDKX2ZDv4qPvSUSwU91JFyoMqz30g",
    duration: "3:58",
  ),
  Song(
    id: 13,
    title: "ចម្ប៉ាបាត់ដំបង",
    artist: "ស៊ីន ស៊ីសាមុត",
    image:
        "https://i1.sndcdn.com/artworks-cBDfpuDqHFw4OtSa-vmcQ8w-t500x500.jpg",
    duration: "3:45",
  ),
  Song(
    id: 14,
    title: "Boyfriend",
    artist: "Ariana Grande & Social House",
    image: "",
    duration: "3:06",
  ),
  Song(
    id: 15,
    title: "I Don't Think That I Like Her",
    artist: "Charlie Puth",
    image: "",
    duration: "3:08",
  ),
  Song(
    id: 16,
    title: "នឹកគ្រប់វេលា",
    artist: "ស៊ីន ស៊ីសាមុត",
    image: "https://i.scdn.co/image/ab67616d0000b273eede583b3df333d32a9ca8d2",
    duration: "3:09",
  ),
  Song(
    id: 17,
    title: "I Don't Think I'm Okay",
    artist: "Bazzi",
    image: "",
    duration: "2:58",
  ),
  Song(
    id: 18,
    title: "Radioactive",
    artist: "Imagine Dragons",
    image: "assets/images/radioactive.jpg",
    duration: "3:06",
  ),
  Song(
    id: 19,
    title: "Closer",
    artist: "The Chainsmokers",
    image: "assets/images/closer.jpg",
    duration: "4:05",
  ),
  Song(
    id: 20,
    title: "Love Yourself",
    artist: "Justin Bieber",
    image: "assets/images/love_yourself.jpg",
    duration: "3:53",
  ),
  Song(
    id: 21,
    title: "Bite Me",
    artist: "ENHYPEN",
    image: "",
    duration: "2:37",
  ),
  Song(
    id: 22,
    title: "Drunk-Dazed",
    artist: "ENHYPEN",
    image: "",
    duration: "3:13",
  ),
  Song(id: 23, title: "FEVER", artist: "ENHYPEN", image: "", duration: "2:53"),
  Song(
    id: 24,
    title: "Sweet Venom",
    artist: "ENHYPEN",
    image: "",
    duration: "2:29",
  ),
  Song(
    id: 25,
    title: "Given-Taken",
    artist: "ENHYPEN",
    image: "",
    duration: "3:04",
  ),
];

//Playlist
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
    songs: [songs[20], songs[21], songs[22], songs[23], songs[24]],
  ),
];

