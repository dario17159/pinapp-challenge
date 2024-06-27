import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinapp_challenge/domain/entities/post.dart';
import 'package:pinapp_challenge/presenter/pages/posts/post_controller.dart';
import 'package:pinapp_challenge/utils/app_colors.dart';
import 'package:pinapp_challenge/utils/icon_routes.dart';

const String infoText =
    'Desarrollar una aplicación Flutter que muestre un listado de posts. Al hacer tap en uno de los posts, se debe abrir una pantalla de detalle que muestre los comentarios asociados a ese post. Esta pantalla de detalle también permite al usuario darle like a un post, este valor se debe reflejar en cada ítem del listado de posts.';

class PostPage extends GetView<PostController> {
  const PostPage({super.key});

  void _showInfo() {
    Get.bottomSheet(
      Wrap(children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(8),
            ),
          ),
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Desafío Técnico',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(infoText),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      child: const Text('Aceptar'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Image.asset(
          IconRoutes.logoPinAppPNG,
          height: kToolbarHeight * .5,
        ),
        actions: [
          IconButton(
            onPressed: () => _showInfo(),
            style: const ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(
                AppColors.lightBlueColor,
              ),
            ),
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.gettingData.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (controller.posts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No data available',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 24),
                    SvgPicture.asset(
                      IconRoutes.emptyDataSVG,
                      width: MediaQuery.of(context).size.width * .7,
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) =>
                  _PostItem(post: controller.posts[index]),
              separatorBuilder: (_, __) => const SizedBox(height: 15),
              itemCount: controller.posts.length,
            );
          }
        },
      ),
    );
  }
}

class _PostItem extends GetWidget<PostController> {
  const _PostItem({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(post.title),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: AppColors.lightBlueColor,
        ),
        onTap: () => controller.onClickPost(post),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
