import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class ViewAppImage extends StatelessWidget {
  final String imageUrl;
  final File fileImage;
  final double height;
  final double width;
  final double radius;
  final ViewState state;
  final BoxFit boxFit;
  final String assetUrl;
  final Color color;
  final BorderRadius borderRadius;

  ViewAppImage(
      {this.imageUrl,
        this.color,
      this.width,
      this.height,
      this.radius: 0.0,
      this.fileImage,
      this.state,
      this.boxFit: BoxFit.cover,this.assetUrl,this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius!=null?borderRadius:BorderRadius.all(Radius.circular(radius)),
      child: Container(
        width: width,
        height: height,
//        color: Theme.of(context).cardColor,
        child: state == ViewState.Busy ? AppConstants.circulerProgressIndicator() : _childWidget(context),
      ),
    );
  }

  Widget _childWidget(BuildContext context) {
    if (fileImage != null) {
      return Image.file(
        fileImage,
        fit: BoxFit.cover,
      );
    } else {
      if (imageUrl != null&&imageUrl!='') {
        return CachedNetworkImage(
          imageUrl: imageUrl,
          fit: boxFit!=null?boxFit:BoxFit.cover,
          placeholder: (context, url) => Container(
            width: height??0 * .5,
            height: height??0 * .5,
            child: Container(),
          ),
        );
      } else {
        return Image.asset(
         assetUrl??AssetsPath.noImage,
          color: color,
          fit: boxFit,
        );
      }
    }
  }
}
