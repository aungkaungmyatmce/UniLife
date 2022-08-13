import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../core/utils/dialog_utils.dart';
import 'cached_network_image_widget.dart';

class PostDetailWidget extends StatelessWidget {
  const PostDetailWidget({
    Key? key,
    required this.statusTitle,
    required this.profilePhotoUrl,
    required this.accName,
    required this.university,
    required this.date,
    this.statusTitlePhotoUrl,
    required this.statusBody,
    this.statusBodyPhotoUrl,
    required this.likeCount,
    required this.cmtCount,
    required this.isLiked,
    required this.isSaved,
    required this.onTapLike,
    required this.onTapCmt,
  }) : super(key: key);

  final String statusTitle;
  final String? profilePhotoUrl;
  final String accName;
  final String university;
  final DateTime date;
  final String? statusTitlePhotoUrl;
  final String statusBody;
  final String? statusBodyPhotoUrl;
  final int likeCount;
  final int cmtCount;
  final bool isLiked;
  final bool isSaved;
  final Function onTapLike;
  final Function onTapCmt;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Text(
              statusTitle,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          // const Divider(
          //   thickness: 1,
          //   indent: 20.0,
          //   endIndent: 20.0,
          // ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                profilePhotoUrl != null
                    ? CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          profilePhotoUrl!,
                        ),
                      )
                    : CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(
                          Icons.person,
                          color: AppColors.whiteColor,
                        ),
                      ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        accName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        university,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat.yMMMd().format(date),
                  style: const TextStyle(
                    color: Color(0xffA9A9A9),
                    fontFamily: 'Roboto',
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          if (statusTitlePhotoUrl != null)
            InkWell(
              onTap: () => DialogUtils.showPreviewImageDialog(
                context,
                statusTitlePhotoUrl,
              ),
              child: CachedNetworkImageWidget(
                imageUrl: statusTitlePhotoUrl,
                width: double.infinity,
                height: 200,
              ),
            ),
          // statusTitlePhotoUrl != null
          //     ? Image.network(
          //         statusTitlePhotoUrl!,
          //         width: MediaQuery.of(context).size.width,
          //         fit: BoxFit.fitWidth,
          //       )
          //     : const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              statusBody,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          statusBodyPhotoUrl != null
              ? Image.network(
                  statusBodyPhotoUrl!,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                )
              : SizedBox(),
          Container(
            height: 40,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: const Color(0xff505050),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: onTapLike(),
                  child: Row(
                    children: [
                      Icon(
                        isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        NumberFormat.compact().format(likeCount),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                InkWell(
                  onTap: onTapCmt(),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.mode_comment_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        NumberFormat.compact().format(cmtCount),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
