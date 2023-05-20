class ActorModel {
  final int id;
  final String name;
  final String? profilePath;

  ActorModel({
    required this.id,
    required this.name,
    this.profilePath,
  });

  factory ActorModel.fromMap(Map<String, dynamic> map) {
    return ActorModel(
      id: map['id'],
      name: map['name'],
      profilePath: map['profile_path'],
    );
  }
}
