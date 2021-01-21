import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/available_status.dart';
import 'package:storeangelApp/core/enums/mobileSize.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

enum AlterNativeProductType { ListScreen, CustomerScreen, CourierScreen }

class AlternativeProductView extends StatefulWidget {
  final Product selectedAlterNative;
  final Product product;
  final int quantity;
  final Function increment, decrement, onTap;
  final AlterNativeProductType productType;
  final List<Product> mainProducts;

  AlternativeProductView(
      {this.selectedAlterNative,
      this.product,
      this.quantity,
      this.increment,
      this.decrement,
      this.onTap,
      this.productType,
      this.mainProducts});

  @override
  _AlternativeProductViewState createState() => _AlternativeProductViewState();
}

class _AlternativeProductViewState extends State<AlternativeProductView> {
  Color get activeColor {
    if (widget.product.availableStatus == AvailableStatus.few) {
      return AppColors.amber;
    } else if (widget.product.availableStatus == AvailableStatus.plenty) {
      return AppColors.green;
    } else if (widget.product.availableStatus == AvailableStatus.runOut) {
      return AppColors.red;
    } else {
      return AppColors.amber;
    }
  }

  String get title {
    if (widget.product.availableStatus == AvailableStatus.few) {
      return AppStrings.FEW.tr();
    } else if (widget.product.availableStatus == AvailableStatus.plenty) {
      return AppStrings.PLENTY.tr();
    } else if (widget.product.availableStatus == AvailableStatus.runOut) {
      return AppStrings.RUN_OUT.tr();
    } else {
      return AppStrings.FEW.tr();
    }
  }

  int total = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConfig.sidepadding,
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: CustomCard(
          side: BorderSide(color: Theme.of(context).backgroundColor),
          elevation: 0,
          child: Padding(
            padding: SizeConfig.innerpadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ViewAppImage(
                  height: SizeConfig.smallImageheight,
                  width: SizeConfig.smallImageheight,
                  radius: 10,
                  imageUrl: widget.product.imageUrl,
                ),
                SizeConfig.horizontalSpaceSmall(),
                Expanded(
                  child: SizedBox(
                    height: SizeConfig.smallImageheight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Text(
                                widget.product.name,
                                style: AppStyles.BlackStyleWithBold800Font_24(context),
                                    maxLines: 2,
                              )),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              title,
                              style: AppStyles.BlackStyleFont_20(context),
                            ),
                            SizeConfig.horizontalSpaceSmall(),
                            FittedBox(
                              child: Text(
                                '2 hours',
                                style: AppStyles.GrayStyle_Font16(context),
                                maxLines: 1,
                              ),
                            )
                          ],
                        ),
                        SizeConfig.verticalSpaceSmall(),
                        LinearPercentIndicator(
                          padding: EdgeInsets.all(0),
                          width: SizeConfig.screenWidth * .35*(SizeConfig.mobileSize==MobileSize.small?0.7:1.0),
                          lineHeight: 4,
                          percent: widget.product.availableStatus == AvailableStatus.few ? 0.2 : 1,
                          backgroundColor: AppColors.lightGreyColor,
                          progressColor: activeColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizeConfig.horizontalSpaceSmall(),
                viewSelectWidget(widget.productType),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget viewSelectWidget(AlterNativeProductType productType) {
    if (productType == AlterNativeProductType.ListScreen) {
      return widget.mainProducts.contains(widget.product)
          ? InkWell(
              child: Icon(
                Icons.remove_circle,
                color: AppColors.green,
                size: SizeConfig.largeIcon,
              ),
              onTap: () {
                widget.decrement();
              },
            )
          : InkWell(
              child: Icon(
                Icons.add_circle_outline,
                size: SizeConfig.largeIcon,
                color: AppColors.green,
              ),
              onTap: () {
                widget.increment();
              },
            );
    } else if (productType == AlterNativeProductType.CustomerScreen) {
      return InkWell(
        child: Icon(
          Icons.remove_circle,
          color: AppColors.green,
          size: SizeConfig.largeIcon,
        ),
        onTap: () {
          widget.decrement();
        },
      );
    } else {
      return InkWell(
        child: SizedBox(
            height: SizeConfig.largeIcon,
            child: widget.selectedAlterNative != null
                ? Container(
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle
                ),
                    child: widget.selectedAlterNative.id == widget.product.id
                        ? Image.asset(AssetsPath.check_checkbox)
                        : Image.asset(AssetsPath.checkboxUncheck))
                : Image.asset(AssetsPath.checkboxUncheck)),
        onTap: () {
          widget.increment();
        },
      );
    }
  }
}
