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
