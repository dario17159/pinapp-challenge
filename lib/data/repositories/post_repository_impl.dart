import 'package:get/get.dart';
import 'package:pinapp_challenge/data/datasources/api_datasource.dart';
import 'package:pinapp_challenge/data/datasources/local_datasource.dart';
import 'package:pinapp_challenge/data/mappers/mappers.dart';
import 'package:pinapp_challenge/domain/datasources/api_datasource.dart';
import 'package:pinapp_challenge/domain/entities/comment.dart';
import 'package:pinapp_challenge/domain/entities/post.dart';
import 'package:pinapp_challenge/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements IPostRepository {
  final IApiDatasource _datasource = Get.find<ApiDatasource>();
  final ILocalDatasource _localDatasource = Get.find<HiveCommentsDatasource>();

  @override
  Future<List<Comment>> getComments(String postId) async {
    final commentsModel = await _datasource.getComments(postId);
    final localComments = await _localDatasource.getLikedComments();
    for (int i = 0; i < commentsModel.length; i++) {
      for (int j = 0; j < localComments.length; j++) {
        if ((commentsModel[i].id == localComments[j].id) &&
            commentsModel[i].postId == localComments[j].postId) {
          commentsModel[i]= localComments[i];
        }
      }
    }
    return commentsModel.map((item) => CommentMapper.toEntity(item)).toList();
  }

  @override
  Future<List<Post>> getPosts() async {
    final postsModel = await _datasource.getPosts();
    return postsModel.map((item) => PostMapper.toEntity(item)).toList();
  }

  @override
  Future<bool> setLikedComment(Comment comment) async {
    return await _localDatasource.setLikedComment(comment);
  }
}
