import 'package:get/get.dart';
import 'package:pinapp_challenge/core/services/dio_service.dart';
import 'package:pinapp_challenge/data/datasources/api_datasource.dart';
import 'package:pinapp_challenge/data/datasources/local_datasource.dart';
import 'package:pinapp_challenge/data/repositories/post_repository_impl.dart';

Future<void> initAppConfig() async {
  await Get.putAsync(() => DioService.dio.dioService, permanent: true);

  Get.lazyPut(() => ApiDatasource(), fenix: true);
  Get.lazyPut(() => HiveCommentsDatasource(), fenix: true);

  Get.lazyPut(() => PostRepositoryImpl(), fenix: true);
}
