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
      padding: EdgeInsets.only(
          left: AppDimens.MARGIN_MEDIUM,
          right: AppDimens.MARGIN_MEDIUM,
          top: AppDimens.MARGIN_MEDIUM_2X),
      child: InkWell(
        onTap: () => Get.toNamed(Paths.POST_DETAIL, arguments: post.id!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoundedCornerImageWidget(
                  post.image!,
                  width: 80,
                  height: 80,
                  cornerRadius: 4,
                ),
                SizedBox(
                  width: AppDimens.MARGIN_MEDIUM,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextViewWidget(
                            post.title!,
                            textSize: AppDimens.TEXT_REGULAR_2X,
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
                        height: AppDimens.MARGIN_MEDIUM_2X,
                      ),
                      TextViewWidget(
                        post.content!,
                        textSize: AppDimens.TEXT_REGULAR,
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
              height: AppDimens.MARGIN_MEDIUM,
            ),
            TextViewWidget(
              "by ${post.postedBy!.username!}",
              textSize: 12,
              fontWeight: FontWeight.w600,
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
