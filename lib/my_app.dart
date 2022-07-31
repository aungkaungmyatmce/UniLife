import 'dart:convert';

import 'package:blog_post_flutter/app/constant/routing/app_pages.dart';
import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/binding/initial_binding.dart';
import 'package:blog_post_flutter/app/data/local/cache_manager.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_home_controller.dart';
import 'package:blog_post_flutter/app/resources/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final postHomeController = Get.put(PostHomeController());

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view

  @override
  void initState() {
    super.initState();
    postHomeController.firstLoad();
    postHomeController.scrollController.value = ScrollController()
      ..addListener(postHomeController.loadMore);
  }

  @override
  void dispose() {
    postHomeController.scrollController.value
        .removeListener(postHomeController.loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kindacode.com'),
        ),
        body: Obx(
          () => postHomeController.isFirstLoadRunning.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: postHomeController.scrollController.value,
                        itemCount: postHomeController.posts.length,
                        itemBuilder: (_, index) => Card(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          child: ListTile(
                            title:
                                Text(postHomeController.posts[index]['title']),
                            subtitle:
                                Text(postHomeController.posts[index]['body']),
                          ),
                        ),
                      ),
                    ),

                    // when the _loadMore function is running
                    if (postHomeController.isLoadMoreRunning.value == true)
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 40),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),

                    // When nothing else to load
                    if (postHomeController.hasNextPage.value == false)
                      Container(
                        padding: const EdgeInsets.only(top: 30, bottom: 40),
                        color: Colors.amber,
                        child: Center(
                          child: Text('You have fetched all of the content'),
                        ),
                      ),
                  ],
                ),
        ));
  }
}

class SamplePage extends StatefulWidget {
  const SamplePage({Key? key}) : super(key: key);

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample Page"),
      ),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints:
              BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const Text("Hello First"),
                    const Text("Hello Second"),
                    const Text("Hello Third"),
                    const Text("Hello Fourth"),
                    const Text("Hello Fifth"),
                    const Text("Hello Six"),
                    Container(
                      height: 500,
                      color: Colors.red,
                    ),
                    Container(
                      height: 500,
                      color: Colors.greenAccent,
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Colors.blue,
                            padding: const EdgeInsets.all(16),
                            child: const Text("Hello End")),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
