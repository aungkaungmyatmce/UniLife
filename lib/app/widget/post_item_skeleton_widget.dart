import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/widget/skeleton_widget.dart';
import 'package:flutter/material.dart';

class PostItemSkeleton extends StatelessWidget {
  const PostItemSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.MARGIN_MEDIUM,
      ),
      child: InkWell(
        onTap: null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SkeletonWidget(
                  width: 50,
                  height: 50,
                ),
                SizedBox(
                  width: AppDimens.MARGIN_MEDIUM,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SkeletonWidget(
                            width: 75,
                          ),
                          Spacer(),
                          SkeletonWidget(
                            width: 75,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppDimens.MARGIN_SMALL,
                      ),
                      SkeletonWidget(
                        width: 100,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: AppDimens.MARGIN_SMALL,
            ),
            SkeletonWidget(
              height: 30,
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
