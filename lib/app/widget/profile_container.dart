import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';

import '../constant/app_colors.dart';
import '../core/utils/dialog_utils.dart';
import '../data/model/authentication/profile_ob.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    Key? key,
    required this.profileOb,
    required this.onTapFollow,
    required this.onTapFollowers,
    this.followButton,
  }) : super(key: key);

  final ProfileOb profileOb;
  final Function onTapFollowers;
  final Function onTapFollow;
  final Widget? followButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      //color: const Color(0xffF2F2F2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              profileOb.profilePicture != null
                  ? InkWell(
                      onTap: () => DialogUtils.showPreviewImageDialog(
                        context,
                        profileOb.profilePicture,
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          profileOb.profilePicture,
                        ),
                      ),
                    )
                  : const CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(
                        Icons.person,
                        color: AppColors.whiteColor,
                      ),
                    ),
              //SizedBox(width: 50),
              InkWell(
                onTap: () {
                  onTapFollowers();
                },
                child: Column(
                  children: [
                    TextViewWidget(
                      profileOb.followers != null
                          ? profileOb.followers!.length.toString()
                          : '0',
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.primaryTextColor,
                    ),
                    const TextViewWidget(
                      'Followers',
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.primaryTextColor,
                    ),
                  ],
                ),
              ),
              //SizedBox(width: 50),
              InkWell(
                onTap: () {
                  onTapFollow();
                },
                child: Column(
                  children: [
                    TextViewWidget(
                      profileOb.following != null
                          ? profileOb.following!.length.toString()
                          : '0',
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.primaryTextColor,
                    ),
                    const TextViewWidget(
                      'Following',
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.primaryTextColor,
                    ),
                  ],
                ),
              ),
              if (profileOb.selfProfile != true) followButton!,
            ],
          ),
          const SizedBox(height: 5),
          TextViewWidget(
            "${profileOb.firstName} ${profileOb.lastName}",
            fontWeight: FontWeight.w600,
            textColor: AppColors.primaryTextColor,
          ),
          SizedBox(height: 5),
          TextViewWidget(
            profileOb.university ?? "",
            fontWeight: FontWeight.w400,
            textColor: AppColors.primaryTextColor,
          ),
        ],
      ),
    );
  }
}
