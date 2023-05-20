class ReviewModel {
  final String author;
  final String? avatarPath;
  final double? rating;
  final String content;

  ReviewModel({
    required this.author,
    this.avatarPath,
    required this.rating,
    required this.content,
  });

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      author: map['author'],
      avatarPath: map['author_details']['avatar_path'],
      rating: map['author_details']?['rating'],
      content: map['content'],
    );
  }
}
