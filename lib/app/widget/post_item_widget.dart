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

import '../constant/app_colors.dart';

class PostItemWidget extends StatefulWidget {
  final PostData postData;
  final Function onTapSeeMore;

  PostItemWidget({
    Key? key,
    required this.postData,
    required this.onTapSeeMore,
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
              child: InkWell(
                onTap: () => widget.onTapSeeMore(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextViewWidget(
                      widget.postData.title ?? "",
                      textSize: 16,
                      fontWeight: FontWeight.w600,
                      lineHeight: 1.5,
                    ),
                    const SizedBox(height: 7),
                    TextViewWidget(
                      widget.postData.content ?? "",
                      textSize: 15,
                      fontWeight: FontWeight.w400,
                      lineHeight: 1.6,
                    ),
                    TextViewWidget(
                      "See More",
                      textSize: 14,
                      lineHeight: 1.3,
                      textAlign: TextAlign.justify,
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.primaryTextColor.withOpacity(0.7),
                    ),
                  ],
                ),
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
        const SizedBox(height: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Get.toNamed(Paths.OTHER_PROFILE,
                      arguments: widget.postData.owner!.id!),
                  child: Row(
                    children: [
                      widget.postData.owner!.profilePicture != null
                          ? CircleAvatar(
                              backgroundColor: AppColors.primaryColor,
                              radius: 15,
                              backgroundImage: NetworkImage(
                                widget.postData.owner!.profilePicture,
                              ),
                            )
                          : const CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.primaryColor,
                              child: Icon(
                                Icons.person,
                                color: AppColors.whiteColor,
                              ),
                            ),
                      const SizedBox(width: 10),
                      TextViewWidget(
                        "${widget.postData.owner!.firstName} ${widget.postData.owner!.lastName}",
                        textSize: 15,
                        textAlign: TextAlign.justify,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: const TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      children: <TextSpan>[
                        if (widget.postData.owner!.university != null)
                          TextSpan(
                              text: ' at ',
                              style: TextStyle(
                                  color: AppColors.primaryTextColor
                                      .withOpacity(0.7))),
                        TextSpan(text: widget.postData.owner!.university),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (widget.postData.createdDate != null)
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: TextViewWidget(
                  DateUtil.convertDateFormat(
                      widget.postData.createdDate!, DAY_MONTH_YEAR_2),
                  textColor: AppColors.primaryTextColor.withOpacity(0.8),
                  textSize: 12,
                ),
              ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    ));
  }
}
