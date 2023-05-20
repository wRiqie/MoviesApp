import 'package:movies_app/app/data/models/actor_model.dart';

class MovieActorsModel {
  final int id;
  final List<ActorModel> actors;
  MovieActorsModel({
    required this.id,
    required this.actors,
  });

  factory MovieActorsModel.fromMap(Map<String, dynamic> map) {
    return MovieActorsModel(
      id: map['id'],
      actors: map['cast'].map<ActorModel>(
        (x) => ActorModel.fromMap(x),
      ).toList(),
    );
  }
}
