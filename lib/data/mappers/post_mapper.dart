import 'package:get/get_utils/get_utils.dart';
import 'package:pinapp_challenge/data/models/models.dart';
import 'package:pinapp_challenge/domain/entities/entities.dart';

class PostMapper {
  static Post toEntity(PostModel dto) => Post(
        id: dto.id?.toString() ?? '',
        title: dto.title?.capitalizeFirst ?? '',
        description: dto.body ?? '',
      );
}
