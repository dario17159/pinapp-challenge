import 'package:pinapp_challenge/domain/entities/entities.dart';

abstract class IPostRepository {
  Future<List<Post>> getPosts();
  Future<List<Comment>> getComments(String postId);
  Future<bool> setLikedComment(Comment comment);
}
