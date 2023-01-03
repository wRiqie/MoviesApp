// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:movies_app/app/data/models/actor.dart';

class MovieActors {
  final int id;
  final List<Actor> actors;
  MovieActors({
    required this.id,
    required this.actors,
  });

  factory MovieActors.fromMap(Map<String, dynamic> map) {
    return MovieActors(
      id: map['id'],
      actors: map['cast'].map<Actor>(
        (x) => Actor.fromMap(x),
      ).toList(),
    );
  }
}
