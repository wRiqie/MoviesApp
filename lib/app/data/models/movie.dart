import '../../core/values/constants.dart';

class Movie {
  final int id;
  final String title;
  final String imgPath;
  final double? voteAverage;

  Movie({
    required this.id,
    required this.title,
    required this.imgPath,
    required this.voteAverage,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      imgPath: map['poster_path'],
      voteAverage: map['vote_average'] * 1.0,
    );
  }

  String get imgUrl => Constants.imageBaseUrl + imgPath;
}
