class MovieModel {
  final int id;
  final String title;
  final String imgPath;
  final double? voteAverage;

  MovieModel({
    required this.id,
    required this.title,
    required this.imgPath,
    required this.voteAverage,
  });

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'],
      title: map['title'],
      imgPath: map['poster_path'],
      voteAverage: map['vote_average'] * 1.0,
    );
  }
}
