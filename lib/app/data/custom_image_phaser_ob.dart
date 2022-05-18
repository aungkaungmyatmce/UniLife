import 'package:blog_post_flutter/app/constant/enum_image_type.dart';

/// image : true
/// type : "gold"

class CustomImagePhaserOb {
  CustomImagePhaserOb({
    this.image,
    this.id,
    this.type = ImageType.networkImage,
  });

  dynamic image;
  ImageType? type;
  int? id;
}
