import 'package:get/get.dart';
import 'package:pinapp_challenge/presenter/pages/post_detail/post_detail_controller.dart';

class PostDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostDetailController>(() => PostDetailController());
  }
}
