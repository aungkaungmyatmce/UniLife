import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/features/profile/controller/profile_controller.dart';
import 'package:blog_post_flutter/app/widget/cached_network_image_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends BaseView<ProfileController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          backgroundColor: AppColors.primaryColor,
          leading: CachedNetworkImageWidget(
            imageUrl:
                'https://static.bangkokpost.com/media/content/20211028/c1_2205267_211028062917.jpg',
            height: 300,
          ),
          border: Border(
            bottom: BorderSide(
              width: .6,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [TextViewWidget("Hello Profile")],
          ),
        )
        // SliverToBoxAdapter(
        //   child: ListView.builder(
        //       shrinkWrap: true,
        //       physics: const NeverScrollableScrollPhysics(),
        //       itemBuilder: (context, i) {
        //
        //         return HorizontalMovieCard(
        //           poster: "This is Poster",
        //           name: "This is title",
        //           backdrop: '',
        //           date: "Not Available",
        //           id: "1",
        //           color: Colors.white,
        //           isMovie:  true, rate: 0.0,
        //
        //         );
        //       },
        //       itemCount:20),
        // )
      ],
    );
  }
}
