 class Song{
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
    this.isFavorite  = false,
  });
 }

 List<Song> songs = [
  Song(
    id: 1,
    title: "Blinding Lights",
    artist: "The Weeknd",
    image: "",
    duration: "3:20",
  ),
  Song(
    id: 2,
    title: "Shape of You",
    artist: "Ed Sheeran",
    image: "",
    duration: "3:53",
  ),
  Song(
    id: 3,
    title: "Levitating",
    artist: "Dua Lipa",
    image: "",
    duration: "3:24",
  ),
  Song(
    id: 4,
    title: "Someone Like You",
    artist: "Adele",
    image: "",
    duration: "4:45",
  ),
  Song(
    id: 5,
    title: "Perfect",
    artist: "Ed Sheeran",
    image: "",
    duration: "4:23",
  ),
  Song(
    id: 6,
    title: "Stay",
    artist: "The Kid LAROI & Justin Bieber",
    image: "",
    duration: "2:21",
  ),
  Song(
    id: 7,
    title: "Bad Guy",
    artist: "Billie Eilish",
    image: "",
    duration: "3:14",
  ),
  Song(
    id: 8,
    title: "Believer",
    artist: "Imagine Dragons",
    image: "",
    duration: "3:24",
  ),
  Song(
    id: 9,
    title: "Senorita",
    artist: "Shawn Mendes & Camila Cabello",
    image: "assets/images/senorita.jpg",
    duration: "3:11",
  ),
  Song(
    id: 10,
    title: "Peaches",
    artist: "Justin Bieber",
    image: "assets/images/peaches.jpg",
    duration: "3:18",
  ),
  Song(
    id: 11,
    title: "Flowers",
    artist: "Miley Cyrus",
    image: "assets/images/flowers.jpg",
    duration: "3:20",
  ),
  Song(
    id: 12,
    title: "Heat Waves",
    artist: "Glass Animals",
    image: "assets/images/heat_waves.jpg",
    duration: "3:58",
  ),
  Song(
    id: 13,
    title: "As It Was",
    artist: "Harry Styles",
    image: "assets/images/as_it_was.jpg",
    duration: "2:47",
  ),
  Song(
    id: 14,
    title: "Calm Down",
    artist: "Rema & Selena Gomez",
    image: "",
    duration: "3:59",
  ),
  Song(
    id: 15,
    title: "Counting Stars",
    artist: "OneRepublic",
    image: "",
    duration: "4:18",
  ),
  Song(
    id: 16,
    title: "Memories",
    artist: "Maroon 5",
    image: "",
    duration: "3:09",
  ),
  Song(
    id: 17,
    title: "Lovely",
    artist: "Billie Eilish & Khalid",
    image: "",
    duration: "3:21",
  ),
  Song(
    id: 18,
    title: "Radioactive",
    artist: "Imagine Dragons",
    image: "",
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
  Song(
    id: 23,
    title: "FEVER",
    artist: "ENHYPEN",
    image: "",
    duration: "2:53",
  ),
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