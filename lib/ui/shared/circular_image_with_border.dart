import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class CircularImageWithBorder extends StatelessWidget {
  final String imageUrl;
  final bool isActive;
  final double height;
  final double opacityVal;
  CircularImageWithBorder({this.opacityVal:1,this.imageUrl,this.isActive:false,this.height:SizeConfig.smallImageheight});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: isActive?height+3:height,
        width: isActive?height+3:height,
        decoration: isActive?BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primaryColor,
            width: 5

          ),
        ):BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.whiteColor,

          ),
        ),
        child: Opacity(
          opacity: opacityVal,
          child: Container(
            height:height,
            width: height,
            child: CircleAvatar(
              backgroundImage: imageUrl!=null?CachedNetworkImageProvider(imageUrl,):AssetImage(AssetsPath.defaultUser),
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: AppColors.whiteColor,

                ),
            ),
          ),
        ));
  }
}
