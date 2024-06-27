class Comment {
  final String id;
  final String postId;
  final String name;
  final String email;
  final String description;
  bool isFavorite;

  Comment({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.description,
    required this.isFavorite,
  });
}
