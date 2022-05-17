import 'package:blog_post_flutter/app/features/favourite/controller/favourite_controller.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteScreen extends GetView<FavouriteController> {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Favourite'),
      ),
      body: const Center(
        child: TextViewWidget("Favourite Screen"),
      )
      // bottomNavigationBar:
    );
  }
}
