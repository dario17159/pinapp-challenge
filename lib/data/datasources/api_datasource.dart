import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pinapp_challenge/data/models/comment_model.dart';
import 'package:pinapp_challenge/data/models/post_model.dart';
import 'package:pinapp_challenge/domain/datasources/api_datasource.dart';

class ApiDatasource implements IApiDatasource {
  final Dio _dio = Get.find<Dio>();

  @override
  Future<List<CommentModel>> getComments(String postId) async {
    final result = await _dio.get('comments?postId=$postId');

    return result.data.map<CommentModel>((item)=> CommentModel.fromJson(item)).toList();
  }

  @override
  Future<List<PostModel>> getPosts() async {
    final result = await _dio.get('posts');
    return result.data.map<PostModel>((item)=> PostModel.fromJson(item)).toList();
  }
}
