import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class OrderCircleIcon extends StatelessWidget {
  final bool isSelected;
  final IconData selectedIcon;
  final IconData nonSelectedIcon;
  final double sizeBig;
  final double sizeSmall;
  final double scaler;
  final double iconSizeSmall;

  const OrderCircleIcon(
      {Key key,
      @required this.isSelected,
      @required this.selectedIcon,
      @required this.nonSelectedIcon,
      this.sizeBig,
      this.sizeSmall,
      this.scaler:.6,
      this.iconSizeSmall})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _sizeBig = this.sizeBig ?? SizeConfig.screenWidth * .2 * scaler;
    final _iconSizeBig = this.sizeBig ?? _sizeBig / 1.5;
    final _sizeSmall = this.sizeSmall ?? SizeConfig.screenWidth * .15 * scaler;
    final _iconSizeSmall = this.iconSizeSmall ?? _sizeSmall / 2;

    return Stack(
      children: [
        Container(
          height: _sizeBig,
          width: _sizeBig,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).cardColor,
            border: isSelected ? Border.all(color: AppColors.green) : Border(),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.5),
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Icon(
            isSelected ? selectedIcon : nonSelectedIcon,
            color: isSelected ? AppColors.green : AppColors.darkGrayColor,
            size: _iconSizeBig,
          ),
        ),
        isSelected
            ? Positioned.fill(
                child: Align(
                alignment: Alignment.topRight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: AppColors.whiteColor, shape: BoxShape.circle),
                  child: Image.asset(
                    AssetsPath.check_checkbox,
                    height: _iconSizeSmall / 1.2,
                    width: _iconSizeSmall / 1.2,
                  ),
                ),
              ))
            : Container()
      ],
    );
  }
}
