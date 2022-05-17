import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_controller.dart';
import 'package:blog_post_flutter/app/widget/default_app_bar_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';

class PostHomeScreen extends BaseView<HomeController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const DefaultAppBar(
      title: "Home",
      isCenterTitle: true,
      elevation: 0,
    );
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: TextViewWidget("Hello Posts"),
    );
  }
}
