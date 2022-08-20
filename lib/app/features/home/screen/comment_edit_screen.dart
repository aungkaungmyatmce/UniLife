import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/features/home/controller/comment_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CommentEditScreen extends BaseView<CommentEditController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 1,
      title: Text(
        'Edit',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.close,
              color: Colors.black,
            )),
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://picsum.photos/200/300',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: TextField(
                        controller: controller.commentEditController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(),
                            fillColor: Colors.grey.shade200),
                        onChanged: (value) {
                          //controller.commentString.value = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                    onPressed: controller.onTapCancel,
                    child: Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 40),
                  ElevatedButton(
                    onPressed: controller.onTapUpdate,
                    child: Text('Update'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 20),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
