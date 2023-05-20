class MovieDetailsModel {
  final int id;
  final String title;
  final String overview;
  final int runTime;
  final String genre;
  final String releaseDate;
  final double? voteAverage;
  final String posterPath;
  final String backdropPath;

  MovieDetailsModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.runTime,
    required this.genre,
    required this.releaseDate,
    required this.posterPath,
    required this.backdropPath,
    this.voteAverage,
  });

  factory MovieDetailsModel.fromMap(Map<String, dynamic> map) {
    return MovieDetailsModel(
      id: map['id'],
      title: map['title'],
      overview: map['overview'],
      runTime: map['runtime'],
      genre: map['genres'][0]['name'],
      releaseDate: map['release_date'],
      voteAverage: map['vote_average'],
      backdropPath: map['backdrop_path'],
      posterPath: map['poster_path'],
    );
  }

  String get releaseDateYear => releaseDate.split('-')[0];
}
