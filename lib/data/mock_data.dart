
import 'package:music_app_project/models/artist.dart';
import 'package:music_app_project/models/playlist.dart';
import 'package:music_app_project/models/song.dart';

//Artist
List<Artist> artists = [
  Artist(
    id: 1,
    name: "The Weeknd",
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Ukrmk8AsNeQazOkSTLUFCtZtvpTlZ9mbK_kmUh5G2UxDzWzV5pvHxClpgY4sLTTSYlwDEpKGDRmo9lIgurbr8_2iMN0Z2yaDAea57pw&s=10",
    bio: "Canadian singer known for R&B, pop, and synthwave music.",
  ),
  Artist(
    id: 2,
    name: "Ed Sheeran",
    image: "https://hips.hearstapps.com/hmg-prod/images/ed-sheeran-attends-the-f1-the-movie-european-premiere-at-news-photo-1757689303.pjpeg?crop=1.00xw:0.781xh;0,0.0385xh&resize=640:*",
    bio: "English singer-songwriter famous for acoustic pop hits.",
  ),
  Artist(
    id: 3,
    name: "Taylor Swift",
    image: "https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcTT5BNeSJ9rJzAx0ssz8arC8yi8NWrar4TOAdsmWVluMkjOcVrM8cDRek7E8f2diXAtiyLheqewTLyICBQ",
    bio: "American singer-songwriter known for country and pop music.",
  ),
  Artist(
    id: 4,
    name: "Billie Eilish",
    image: "https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcTHNqOAZrIMqww39C5KMIai4Q_1U154DRZSNYZiyOhmija8giz2M1cU1Nft4_d45_nlAofwuA2H7bmvwMY",
    bio: "Grammy-winning artist recognized for her unique alternative pop style.",
  ),
  // Artist(
  //   id: 5,
  //   name: "Imagine Dragons",
  //   image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Ukrmk8AsNeQazOkSTLUFCtZtvpTlZ9mbK_kmUh5G2UxDzWzV5pvHxClpgY4sLTTSYlwDEpKGDRmo9lIgurbr8_2iMN0Z2yaDAea57pw&s=10",
  //   bio: "American pop rock band best known for energetic anthems.",
  // ),
  // Artist(
  //   id: 6,
  //   name: "Dua Lipa",
  //   image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Ukrmk8AsNeQazOkSTLUFCtZtvpTlZ9mbK_kmUh5G2UxDzWzV5pvHxClpgY4sLTTSYlwDEpKGDRmo9lIgurbr8_2iMN0Z2yaDAea57pw&s=10",
  //   bio: "British-Albanian pop singer with multiple chart-topping songs.",
  // ),
  Artist(
    id: 7,
    name: "Justin Bieber",
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFQ1614eHneTTPuGNI6ubaSwvxRqSjY3IRdGXPEMVBH9HihdadQ2ty2FVEjIJmAEogCvneMd_EpyPWWnSUofpevxfKx9L9O3NAd6mSpg&s=10",
    bio: "Canadian pop singer with numerous international hits.",
  ),
  Artist(
    id: 8,
    name: "Adele",
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBZsutpQn8Hb1aVSnrvSW_yhfr2B0vYKgy4y7c2jEKNIQtVOHiJ52Qm-gvybyo9hTaXeqbIvLDgDMd4HaYjpue8CTWMSwo6R5OMA0OIx0&s=10",
    bio: "British singer celebrated for her soulful voice and emotional ballads.",
  ),
  Artist(
    id: 9,
    name: "Bruno Mars",
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5-f_ybMoiTZGNvCjQgCW_BSZs8gnN0wR7zja2O6FjBL0Odk2Ti2-aM2CVCZnaOmkbuHpz7QgpiZBZ-KEwS3p2GzL24h6Q9gscTQgqbQ&s=10",
    bio: "American singer-songwriter blending pop, funk, soul, and R&B.",
  ),
//   Artist(
//     id: 10,
//     name: "Maroon 5",
//     image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Ukrmk8AsNeQazOkSTLUFCtZtvpTlZ9mbK_kmUh5G2UxDzWzV5pvHxClpgY4sLTTSYlwDEpKGDRmo9lIgurbr8_2iMN0Z2yaDAea57pw&s=10",
//     bio: "American pop rock band led by vocalist Adam Levine.",
//   ),
//   Artist(
//   id: 11,
//   name: "ENHYPEN",
//   image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Ukrmk8AsNeQazOkSTLUFCtZtvpTlZ9mbK_kmUh5G2UxDzWzV5pvHxClpgY4sLTTSYlwDEpKGDRmo9lIgurbr8_2iMN0Z2yaDAea57pw&s=10",
//   bio: "South Korean boy group formed through the survival show I-LAND, known for songs like Bite Me, FEVER, Drunk-Dazed, and Sweet Venom.",
// ),
];

// Song
List<Song> songs = [
  Song(
    id: 1,
    title: "Blinding Lights",
    artist: "The Weeknd",
    image:
        "https://upload.wikimedia.org/wikipedia/en/e/e6/The_Weeknd_-_Blinding_Lights.png",
    video : "https://youtu.be/4NRXx6U8ABQ?si=5CMWQDzCplb8BV5r",
    duration: "3:20",
  ),
  Song(
    id: 2,
    title: "Shape of You",
    artist: "Ed Sheeran",
    image:
        "https://m.media-amazon.com/images/M/MV5BMGNlODRhYjEtMTY3ZC00Y2QwLTk0Y2ItNDE0NDUyYmQxYWQ4XkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
    video : "https://youtu.be/JGwWNGJdvx8?si=DMV90SIInjsub5Pz",
    duration: "3:53",
  ),
  Song(
    id: 3,
    title: "Levitating",
    artist: "Dua Lipa",
    image:
        "https://i1.sndcdn.com/artworks-orxd3Qu4MvUnj9Wp-zpTayQ-t500x500.jpg",
    video : "https://youtu.be/TUVcZfQe-Kw?si=78fnwSWSWpVcoR_f",
    duration: "3:24",
  ),
  Song(
    id: 4,
    title: "Someone Like You",
    artist: "Adele",
    image:
        "https://upload.wikimedia.org/wikipedia/en/7/7a/Adele_-_Someone_Like_You.png",
    video : "https://youtu.be/hLQl3WQQoQ0?si=iScxIl851xaQhwYM",
    duration: "4:45",
  ),
  Song(
    id: 5,
    title: "នឹកគ្រប់វេលា",
    artist: "Sin Sisamuth",
    image:
        "https://upload.wikimedia.org/wikipedia/en/7/70/Lewis_Capaldi_-_Someone_You_Loved.png",
    video: "lib/audios/nirkKrobVeaLea.mp4",
    duration: "3:02",
  ),
  // Song(
  //   id: 5,
  //   title: "Perfect",
  //   artist: "Ed Sheeran",
  //   image:
  //       "https://upload.wikimedia.org/wikipedia/en/8/80/Ed_Sheeran_Perfect_Single_cover.jpg",
  //   duration: "4:23",
  // ),
  // Song(
  //   id: 6,
  //   title: "Stay",
  //   artist: "The Kid LAROI & Justin Bieber",
  //   image: "https://i.scdn.co/image/ab67616d0000b273aed1660585c1e3c9ffb50b6a",
  //   duration: "2:21",
  // ),
  // Song(
  //   id: 7,
  //   title: "Bad Guy",
  //   artist: "Billie Eilish",
  //   image:
  //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPlgd3LTQBpmHx8V_VJFgNlLwYQDNQe52Gu5D7NfGbczcMrl4RLHak-Bw&s=10",
  //   duration: "3:14",
  // ),
  // Song(
  //   id: 8,
  //   title: "Believer",
  //   artist: "Imagine Dragons",
  //   image: "https://i.scdn.co/image/ab67616d0000b2735675e83f707f1d7271e5cf8a",
  //   duration: "3:24",
  // ),
  // Song(
  //   id: 9,
  //   title: "Senorita",
  //   artist: "Shawn Mendes & Camila Cabello",
  //   image:
  //       "https://i1.sndcdn.com/artworks-HAZ3Ru34GTQ3rAmd-LVwITA-t500x500.jpg",
  //   duration: "3:11",
  // ),
  // Song(
  //   id: 10,
  //   title: "Peaches",
  //   artist: "Justin Bieber",
  //   image:
  //       "https://i1.sndcdn.com/artworks-eb0MriwCeIEzf4mo-bUQc2A-t500x500.jpg",
  //   duration: "3:18",
  // ),
  // Song(
  //   id: 11,
  //   title: "Flowers",
  //   artist: "Miley Cyrus",
  //   image:
  //       "https://m.media-amazon.com/images/M/MV5BYzU3ZTFkZDctYmNlNi00ZjMxLTgwNGItYTI1YjdmOWJiNTQzXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
  //   duration: "3:20",
  // ),
  // Song(
  //   id: 12,
  //   title: "ស្ទឹងសែនប៉ារីស",
  //   artist: "សូ សាវឿន",
  //   image:
  //       "https://i.ytimg.com/vi/fQtH9_dC5yc/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLDKX2ZDv4qPvSUSwU91JFyoMqz30g",
  //   duration: "3:58",
  // ),
  // Song(
  //   id: 13,
  //   title: "ចម្ប៉ាបាត់ដំបង",
  //   artist: "ស៊ីន ស៊ីសាមុត",
  //   image:
  //       "https://i1.sndcdn.com/artworks-cBDfpuDqHFw4OtSa-vmcQ8w-t500x500.jpg",
  //   duration: "3:45",
  // ),
  // Song(
  //   id: 14,
  //   title: "Boyfriend",
  //   artist: "Ariana Grande & Social House",
  //   image: "",
  //   duration: "3:06",
  // ),
  // Song(
  //   id: 15,
  //   title: "I Don't Think That I Like Her",
  //   artist: "Charlie Puth",
  //   image: "",
  //   duration: "3:08",
  // ),
  // Song(
  //   id: 16,
  //   title: "នឹកគ្រប់វេលា",
  //   artist: "ស៊ីន ស៊ីសាមុត",
  //   image: "https://i.scdn.co/image/ab67616d0000b273eede583b3df333d32a9ca8d2",
  //   duration: "3:09",
  // ),
  // Song(
  //   id: 17,
  //   title: "I Don't Think I'm Okay",
  //   artist: "Bazzi",
  //   image: "",
  //   duration: "2:58",
  // ),
  // Song(
  //   id: 18,
  //   title: "Radioactive",
  //   artist: "Imagine Dragons",
  //   image: "assets/images/radioactive.jpg",
  //   duration: "3:06",
  // ),
  // Song(
  //   id: 19,
  //   title: "Closer",
  //   artist: "The Chainsmokers",
  //   image: "assets/images/closer.jpg",
  //   duration: "4:05",
  // ),
  // Song(
  //   id: 20,
  //   title: "Love Yourself",
  //   artist: "Justin Bieber",
  //   image: "assets/images/love_yourself.jpg",
  //   duration: "3:53",
  // ),
  // Song(
  //   id: 21,
  //   title: "Bite Me",
  //   artist: "ENHYPEN",
  //   image: "",
  //   duration: "2:37",
  // ),
  // Song(
  //   id: 22,
  //   title: "Drunk-Dazed",
  //   artist: "ENHYPEN",
  //   image: "",
  //   duration: "3:13",
  // ),
  // Song(id: 23, title: "FEVER", artist: "ENHYPEN", image: "", duration: "2:53"),
  // Song(
  //   id: 24,
  //   title: "Sweet Venom",
  //   artist: "ENHYPEN",
  //   image: "",
  //   duration: "2:29",
  // ),
  // Song(
  //   id: 25,
  //   title: "Given-Taken",
  //   artist: "ENHYPEN",
  //   image: "",
  //   duration: "3:04",
  // ),
];

//Playlist (use safe selections from `songs` to avoid range errors)
List<Playlist> playlists = [
  Playlist(id: 1, name: "Top Hits", songs: songs.take(5).toList()),
  Playlist(id: 2, name: "Workout Mix", songs: songs.skip(5).take(5).toList()),
  Playlist(id: 3, name: "Chill Vibes", songs: songs.skip(10).take(5).toList()),
  Playlist(id: 4, name: "Romantic Songs", songs: songs.skip(15).take(5).toList()),
  Playlist(id: 5, name: "Mixed Favorites", songs: songs.take(10).toList()),
];

