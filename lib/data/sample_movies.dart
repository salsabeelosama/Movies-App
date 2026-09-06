import '../models/movie.dart';

/// Sample data using the bundled poster assets, so the app runs and looks
/// right without a backend wired up yet. Replace with your real API/DB
/// call — just keep `posterUrl` pointing at an `assets/...` path (local)
/// or an `https://...` URL (remote); both are supported everywhere a
/// poster is rendered.
final List<Movie> sampleMovies = [
  const Movie(
    id: '1',
    title: 'Black Widow',
    posterUrl: 'assets/Images/black_widow.png',
    year: 2021,
    rating: 7.7,
  ),
  const Movie(
    id: '2',
    title: 'Captain America: The First Avenger',
    posterUrl: 'assets/Images/captain_america.png',
    year: 2011,
    rating: 7.7,
  ),
  const Movie(
    id: '3',
    title: 'Iron Man 3',
    posterUrl: 'assets/Images/iron_man_3.png',
    year: 2013,
    rating: 7.7,
  ),
  const Movie(
    id: '4',
    title: 'Captain America: Civil War',
    posterUrl: 'assets/Images/civil_war.png',
    year: 2016,
    rating: 7.7,
  ),
  const Movie(
    id: '5',
    title: 'The Avengers',
    posterUrl: 'assets/Images/avengers.png',
    year: 2012,
    rating: 7.7,
  ),
  const Movie(
    id: '6',
    title: 'Doctor Strange in the Multiverse of Madness',
    posterUrl: 'assets/Images/doctor_strange_card.png',
    detailsPosterUrl: 'assets/Images/doctor_strange_poster.png',
    posterGradientUrl: 'assets/Images/doctor_strange_gradient.png',
    year: 2022,
    rating: 7.6,
    likes: 15,
    durationMinutes: 90,
    screenshotUrls: [],
  ),
];
