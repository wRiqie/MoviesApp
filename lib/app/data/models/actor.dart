import '../../core/values/constants.dart';

class Actor {
  final int id;
  final String name;
  final String? profilePath;

  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
  });

  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      id: map['id'],
      name: map['name'],
      profilePath: map['profile_path'],
    );
  }

  String? get profilePhoto =>
      profilePath != null ? Constants.imageBaseUrl + profilePath! : null;
}
