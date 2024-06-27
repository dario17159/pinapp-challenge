import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pinapp_challenge/core/errors/failures.dart';
import 'package:pinapp_challenge/data/mappers/mappers.dart';
import 'package:pinapp_challenge/data/models/models.dart';
import 'package:pinapp_challenge/domain/entities/comment.dart';

abstract class ILocalDatasource {
  Future<bool> setLikedComment(Comment comment);
  Future<List<CommentModel>> getLikedComments();
}

class HiveCommentsDatasource implements ILocalDatasource {
  HiveCommentsDatasource() {
    Hive.initFlutter();
  }

  @override
  Future<List<CommentModel>> getLikedComments() async {
    try {
      Box<dynamic> box = await Hive.openBox('comments');
      return box.values.map((item) => CommentModel.fromJson(item)).toList();
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure();
    }
  }

  @override
  Future<bool> setLikedComment(Comment comment) async {
    try {
      Box<dynamic> box = await Hive.openBox('comments');
      if (comment.isFavorite) {
        await box.put(comment.id, CommentMapper.toModel(comment).toJson());
      } else {
        await box.delete(comment.id);
      }
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure();
    }
  }
}
