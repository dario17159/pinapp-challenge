import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinapp_challenge/domain/entities/comment.dart';
import 'package:pinapp_challenge/presenter/pages/post_detail/post_detail_controller.dart';
import 'package:pinapp_challenge/utils/icon_routes.dart';

class PostDetailPage extends GetView<PostDetailController> {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Image.asset(
            IconRoutes.logoPinAppPNG,
            height: kToolbarHeight * .5,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  controller.post.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: Text(controller.post.description),
              ),
            ),
            Obx(() {
              if (controller.gettingData.value) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                if (controller.comments.isEmpty) {
                  return Expanded(
                    child: Center(
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
                    ),
                  );
                }
                return Expanded(
                  child: SafeArea(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (_, index) =>
                          _CommentItem(comment: controller.comments[index]),
                      separatorBuilder: (_, __) => const SizedBox(height: 15),
                      itemCount: controller.comments.length,
                    ),
                  ),
                );
              }
            })
          ],
        ));
  }
}

class _CommentItem extends StatefulWidget {
  const _CommentItem({
    required this.comment,
  });

  final Comment comment;

  @override
  State<_CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<_CommentItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${widget.comment.name}\n',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: widget.comment.email,
                    style: const TextStyle(
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.comment.description),
            SizedBox(
              width: double.infinity,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      widget.comment.isFavorite = !widget.comment.isFavorite;
                    });
                    Get.find<PostDetailController>()
                        .onClickComment(widget.comment);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: widget.comment.isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
