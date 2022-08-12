import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/utils/date_utils.dart';
import 'package:blog_post_flutter/app/core/utils/dialog_utils.dart';
import 'package:blog_post_flutter/app/core/utils/global_key_utils.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_home_controller.dart';
import 'package:blog_post_flutter/app/widget/cached_network_image_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostItemWidget extends StatefulWidget {
  final PostData postData;

  PostItemWidget({
    Key? key,
    required this.postData,
  }) : super(key: key);

  @override
  State<PostItemWidget> createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextViewWidget(
                    widget.postData.title ?? "",
                    textSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 5),
                  TextViewWidget(
                    widget.postData.content ?? "",
                    textSize: 15,
                    lineHeight: 1.3,
                    textAlign: TextAlign.justify,
                    fontWeight: FontWeight.w400,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Paths.POST_DETAIL, arguments: widget.postData.id);
                    },
                    child: const TextViewWidget(
                      "See More",
                      textSize: 14,
                      lineHeight: 1.3,
                      textAlign: TextAlign.justify,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            if (widget.postData.image != null)
              InkWell(
                onTap: () => DialogUtils.showPreviewImageDialog(
                  context,
                  widget.postData.image,
                ),
                child: CachedNetworkImageWidget(
                  imageUrl: widget.postData.image,
                  width: 72,
                  height: 72,
                ),
              ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            widget.postData.owner!.profilePicture != null
                ? InkWell(
                    onTap: () => DialogUtils.showPreviewImageDialog(
                        context, widget.postData.owner!.profilePicture),
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(border: Border.all(width: 2)),
                      child: CachedNetworkImageWidget(
                        imageUrl: widget.postData.owner!.profilePicture,
                        width: 25,
                        height: 25,
                      ),
                    ),
                  )
                : const SizedBox(),
            widget.postData.owner!.profilePicture != null
                ? const SizedBox(width: 10)
                : const SizedBox(),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            "${widget.postData.owner!.firstName} ${widget.postData.owner!.lastName}"),
                    if (widget.postData.owner!.university != null)
                      const TextSpan(
                          text: ' in ',
                          style: TextStyle(color: Color(0XFFA9A9A9))),
                    TextSpan(text: widget.postData.owner!.university),
                  ],
                ),
              ),
            ),
            // Obx(() => IconButton(
            //   icon: Icon(Icons.bookmark_border,
            //       size: 28,
            //       color: postHomeController.isFavourite.value == true
            //           ? Colors.red
            //           : Color(0xffA9A9A9)),
            //   onPressed: () {
            //     if(GlobalVariable.token == null){
            //       Get.offAllNamed(Paths.MAIN_HOME,arguments: 4);
            //     }else{
            //       postHomeController.savePost(postHomeController.isFavourite.value);
            //     }
            //   },
            // ),
          ],
        ),
        if (widget.postData.createdDate != null)
          TextViewWidget(
            DateUtil.convertDateFormat(widget.postData.createdDate!, DAY_MONTH_YEAR),
            textColor: Color(0xffA9A9A9),
            textSize: 12,
          )
      ],
    ));
  }
}
