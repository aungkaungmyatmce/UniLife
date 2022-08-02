import 'package:blog_post_flutter/app/core/utils/date_utils.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/widget/cached_network_image_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';

class PostItemWidget extends StatelessWidget {
  final PostData postData;

  const PostItemWidget({
    Key? key,
    required this.postData,
  }) : super(key: key);

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
                    postData.title ?? "",
                    textSize: 18,
                    textAlign: TextAlign.justify,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 5),
                  TextViewWidget(
                    postData.content ?? "",
                    textSize: 15,
                    lineHeight: 1.3,
                    textAlign: TextAlign.justify,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            if (postData.image != null)
              CachedNetworkImageWidget(
                imageUrl: postData.image,
                width: 72,
                height: 72,
              ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            postData.owner!.profilePicture != null
                ? Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(border: Border.all(width: 2)),
                    child: CachedNetworkImageWidget(
                      imageUrl: postData.owner!.profilePicture,
                      width: 25,
                      height: 25,
                    ),
                  )
                : const SizedBox(),
            postData.owner!.profilePicture != null
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
                            "${postData.owner!.firstName} ${postData.owner!.lastName}"),
                    if (postData.owner!.university != null)
                      const TextSpan(
                          text: ' in ',
                          style: TextStyle(color: Color(0XFFA9A9A9))),
                    TextSpan(text: postData.owner!.university),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.bookmark_border,
                  size: 28,
                  color: postData.isSaved == true
                      ? Colors.red
                      : Color(0xffA9A9A9)),
              onPressed: () {
                print("Toggle Save");
              },
            ),
          ],
        ),
        if (postData.createdDate != null)
          TextViewWidget(
            DateUtil.convertDateFormat(postData.createdDate!, DAY_MONTH_YEAR),
            textColor: Color(0xffA9A9A9),
            textSize: 12,
          )
      ],
    ));
  }
}
