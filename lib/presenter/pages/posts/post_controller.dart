import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinapp_challenge/data/repositories/post_repository_impl.dart';
import 'package:pinapp_challenge/domain/entities/post.dart';
import 'package:pinapp_challenge/domain/repositories/post_repository.dart';
import 'package:pinapp_challenge/presenter/pages/post_detail/post_detail_binding.dart';
import 'package:pinapp_challenge/presenter/pages/post_detail/post_detail_page.dart';

class PostController extends GetxController {
  final IPostRepository _postRepository = Get.find<PostRepositoryImpl>();

  final RxBool gettingData = true.obs;
  final RxList<Post> posts = <Post>[].obs;
  @override
  void onReady() {
    _getPostList();
    super.onReady();
  }

  Future<void> _getPostList() async {
    try {
      posts.clear();
      final postsList = await _postRepository.getPosts();
      posts.addAll(postsList);
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

  void onClickPost(Post post) => Get.to(
        () => const PostDetailPage(),
        binding: PostDetailBinding(),
        arguments: post
      );
}
