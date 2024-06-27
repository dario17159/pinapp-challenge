import 'package:get/get_utils/get_utils.dart';
import 'package:pinapp_challenge/data/models/models.dart';
import 'package:pinapp_challenge/domain/entities/comment.dart';

class CommentMapper {
  static Comment toEntity(CommentModel dto) => Comment(
        id: dto.id?.toString() ?? '',
        postId: dto.postId?.toString() ?? '',
        name: dto.name?.toUpperCase() ?? '',
        email: dto.email?.toLowerCase() ?? '',
        description: dto.body?.capitalizeFirst ?? '',
        isFavorite: dto.isFavorite ?? false,
      );
  static CommentModel toModel(Comment entity) => CommentModel(
        id: int.parse(entity.id),
        postId: int.parse(entity.postId),
        name: entity.name,
        email: entity.email,
        body: entity.description,
        isFavorite: entity.isFavorite,
      );
}
