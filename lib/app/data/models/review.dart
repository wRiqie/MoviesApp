class Review {
  final String author;
  final String? avatarPath;
  final double? rating;
  final String content;

  Review({
    required this.author,
    this.avatarPath,
    required this.rating,
    required this.content,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      author: map['author'],
      avatarPath: map['author_details']['avatar_path'],
      rating: map['author_details']?['rating'],
      content: map['content'],
    );
  }
}
