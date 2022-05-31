import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/utils/date_utils.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/widget/rounded_corner_image_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostItemWidget extends StatelessWidget {
  final PostData post;

  const PostItemWidget({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.MARGIN_MEDIUM,
      ),
      child: InkWell(
        onTap: () => Get.toNamed(Paths.POST_DETAIL, arguments: post.id!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                post.image != null
                    ? RoundedCornerImageWidget(
                        post.image!,
                        width: 50,
                        height: 50,
                        cornerRadius: 4,
                      )
                    : const SizedBox(),
                post.image != null
                    ? SizedBox(
                        width: AppDimens.MARGIN_MEDIUM,
                      )
                    : SizedBox(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextViewWidget(
                            post.title!,
                            textSize: AppDimens.TEXT_REGULAR,
                            textColor: AppColors.titleTextColor,
                            fontWeight: FontWeight.w700,
                          ),
                          Spacer(),
                          TextViewWidget(
                            DateUtil.convertDateFormat(
                                post.createdDate!, DAY_MONTH_YEAR),
                            textSize: 12,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppDimens.MARGIN_EXTRA_SMALL,
                      ),
                      TextViewWidget(
                        "by ${post.postedBy!.username!}",
                        textSize: AppDimens.TEXT_SMALL,
                        textColor: AppColors.secondaryTextColor,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.justify,
                        maxLine: 3,
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: AppDimens.MARGIN_MEDIUM_2X,
            ),
            TextViewWidget(
              "${post.content}",
              textSize: 12,
              maxLine: 2,
              fontWeight: FontWeight.w400,
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
