import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class CircleIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final Size size;
  final double iconSize;
  final bool hasConstraints;
  final String svgAsset;

  const CircleIcon(
      {Key key,
      this.svgAsset,
      this.icon,
      this.backgroundColor,
      this.iconColor,
      this.size,
      this.iconSize,
      this.hasConstraints: true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: size?.height ?? SizeConfig.smallerImageheight,
      width: size?.width ?? SizeConfig.smallerImageheight,
      constraints: hasConstraints
          ? BoxConstraints(
              maxHeight: size?.height ?? SizeConfig.smallerImageheight,
              minHeight: size?.height ?? SizeConfig.smallerImageheight,
              minWidth: size?.width ?? SizeConfig.smallerImageheight,
              maxWidth: size?.width ?? SizeConfig.smallerImageheight)
          : null,
      decoration: BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
      child: svgAsset != null
          ? SizedBox(
              height: iconSize != null ? iconSize : (size?.height ?? SizeConfig.smallerImageheight) / 2,
              child: SvgPicture.asset(
                svgAsset,
                color: iconColor,
                fit: BoxFit.contain,
              ))
          : Icon(
              icon,
              color: iconColor,
              size: iconSize != null ? iconSize : (size?.height ?? SizeConfig.smallerImageheight) / 2,
            ),
    );
  }
}
