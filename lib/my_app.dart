import 'package:blog_post_flutter/app/constant/routing/app_pages.dart';
import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/binding/initial_binding.dart';
import 'package:blog_post_flutter/app/data/local/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/core/config/size_config.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;

  @override
  void initState() {
    var data =
        Get.find<CacheManager>().getString(CacheManagerKey.loginResponseData) ??
            "";
    if (data.isNotEmpty) {
      isLogin = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init();
    return GetMaterialApp(
      title: "Blog Post",
      locale: Get.find<CacheManager>().getLocale(),
      fallbackLocale: const Locale('my', 'MM'),
      initialRoute: Paths.MAIN_HOME,
      initialBinding: InitialBinding(),
      //theme: lightTheme(),
      getPages: AppPages.routes,
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
    );
  }
}
