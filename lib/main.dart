import 'package:blog_post_flutter/app/data/local/cache_manager.dart';
import 'package:blog_post_flutter/my_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await Get.putAsync<CacheManager>(() async => CacheManager().init());
  runApp(const MyApp());
}
