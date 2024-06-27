import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinapp_challenge/data/repositories/post_repository_impl.dart';
import 'package:pinapp_challenge/domain/entities/comment.dart';
import 'package:pinapp_challenge/domain/entities/post.dart';
import 'package:pinapp_challenge/domain/repositories/post_repository.dart';

class PostDetailController extends GetxController {
  final IPostRepository _postRepository = Get.find<PostRepositoryImpl>();

  final RxBool gettingData = true.obs;
  final RxList<Comment> comments = <Comment>[].obs;
  late Post post;

  @override
  void onInit() {
    post = Get.arguments as Post;
    super.onInit();
  }

  @override
  void onReady() {
    _getComments();
    super.onReady();
  }

  Future<void> _getComments() async {
    try {
      comments.clear();
      final commentsList = await _postRepository.getComments(post.id);
      comments.addAll(commentsList);
      gettingData.value = false;
    } catch (e) {
      gettingData.value = false;
      Get.snackbar(
        'Atencion',
        'No se pudo obtener los posts',
        margin: const EdgeInsets.all(16),
      );
    }
  }

  Future<void> onClickComment(Comment comment) async {
    await _postRepository.setLikedComment(comment);
  }
}
