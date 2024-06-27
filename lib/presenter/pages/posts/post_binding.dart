import 'package:get/get.dart';
import 'package:pinapp_challenge/presenter/pages/posts/post_controller.dart';

class PostBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(() => PostController());
  }
}
