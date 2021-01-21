import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class ItemThumbnailImageWidget extends StatelessWidget {
  final String url;
  ItemThumbnailImageWidget({this.url});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.whiteColor,
      ),
      child: ViewAppImage(
        imageUrl: url,
        height: SizeConfig.smallerImageheight75,
        width: SizeConfig.smallerImageheight75,
        radius:  SizeConfig.smallerImageheight75,
        boxFit: BoxFit.contain,
      ),
    );
  }
}
