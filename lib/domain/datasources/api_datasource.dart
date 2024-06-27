

import 'package:pinapp_challenge/data/models/models.dart';

abstract class IApiDatasource {
  Future<List<PostModel>> getPosts();
  Future<List<CommentModel>> getComments(String postId);
}
