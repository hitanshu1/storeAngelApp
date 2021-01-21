import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/ui/shared/circleIcon.dart';
import 'package:storeangelApp/ui/shared/clipper/slider_clipper.dart';

enum OrderCourierStatus{SelectProduct,Location,Calculate}

class OrderCourierStatusWidget extends StatelessWidget {
  final OrderCourierStatus status;
  OrderCourierStatusWidget({this.status});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: SizeConfig.sidepadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleIcon(
                      svgAsset: AssetsPath.svgSelectProduct,
                      icon: StoreangelIcons.select_product,
                      backgroundColor: status==OrderCourierStatus.SelectProduct?AppColors.primaryColor:AppColors.lightGrayLittleColor,
                      iconColor: status==OrderCourierStatus.SelectProduct?AppColors.whiteColor:AppColors.black,
                      hasConstraints: false,
                    ),
                    Positioned.fill(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: SizedBox(
                              height: SizeConfig.smallerImageheight * .3,
                              child: SvgPicture.asset(AssetsPath.green_border_selected)),
                        ))
                  ],
                ),
                Container(
                  height: 5,
                  width: SizeConfig.screenWidth * .1,
                  color: AppColors.lightGrayLittleColor,
                ),
                Flexible(
                  child: ClipPath(
                    clipper: SilderClipper(),
                    child: Container(
                      height: 15,
                      width: 15,
                      color: AppColors.lightGrayLittleColor,
                    ),
                  ),
                ),
                CircleIcon(
                  icon: StoreangelIcons.location_pin,
                  backgroundColor: status==OrderCourierStatus.Location?AppColors.primaryColor:AppColors.lightGrayLittleColor,
                  iconColor: status==OrderCourierStatus.Location?AppColors.whiteColor:AppColors.black,
                  hasConstraints: false,
                ),
                Container(
                  height: 5,
                  width: SizeConfig.screenWidth * .1,
                  color: AppColors.lightGrayLittleColor,
                ),
                Flexible(
                  child: ClipPath(
                    clipper: SilderClipper(),
                    child: Container(
                      height: 15,
                      width: 15,
                      color: AppColors.lightGrayLittleColor,
                    ),
                  ),
                ),
                CircleIcon(
                  icon: StoreangelIcons.calculator_icon,
                  backgroundColor: status==OrderCourierStatus.Calculate?AppColors.primaryColor:AppColors.lightGrayLittleColor,
                  iconColor: status==OrderCourierStatus.Calculate?AppColors.whiteColor:AppColors.black,
                  hasConstraints: false,
                )
              ],
            ),
          ),
          SizeConfig.verticalSpaceMedium(),
        ],
      ),
    );
  }
}
