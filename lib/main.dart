import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pinapp_challenge/initalization_config.dart';
import 'package:pinapp_challenge/presenter/pages/posts/post_binding.dart';
import 'package:pinapp_challenge/presenter/pages/posts/post_page.dart';
import 'package:pinapp_challenge/utils/app_colors.dart';

Future<void> main() async {
  await initAppConfig();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: ThemeData(
        colorSchemeSeed: AppColors.redColor,
      ),
      initialBinding: PostBinding(),
      home: const PostPage(),
    );
  }
}
