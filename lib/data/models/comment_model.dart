import 'dart:convert';

class CommentModel {
  final int? postId;
  final int? id;
  final String? name;
  final String? email;
  final String? body;
  final bool? isFavorite;

  CommentModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
    required this.isFavorite
  });

  factory CommentModel.fromRawJson(String str) =>
      CommentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
        isFavorite: json["isFavorite"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
        "isFavorite": isFavorite,
      };
}
