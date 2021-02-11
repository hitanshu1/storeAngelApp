import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/enums/item_status.dart';

class CustomItemStatusWidget extends StatefulWidget {
  final double size;
  final ItemStatus status;
  final double padding;
  final Size minSize;
  final Size maxSize;
  final double margin;
  final double iconSize;
  final Widget child;
  CustomItemStatusWidget(
      {this.size: 30, @required this.status, this.minSize, this.maxSize, this.margin, this.padding: 0, this.iconSize,this.child});

  @override
  _CustomItemStatusWidgetState createState() => _CustomItemStatusWidgetState();
}

class _CustomItemStatusWidgetState extends State<CustomItemStatusWidget> {


  LinearGradient get _activeBackgroundColor {
    switch (widget.status) {
      case ItemStatus.Selected:
        return AppColors.primaryGradient;
      case ItemStatus.Few:
        return AppColors.yellowGradient;
      case ItemStatus.UnAvailable:
        return AppColors.redGradient;
      default:
        return AppColors.amberGradient;
    }
  }

  Border get _activeBorder {
    switch (widget.status) {
      case ItemStatus.Few:

        return Border.all(color: AppColors.amber, width: 3);
//      case ItemStatus.Available:
//        _iconColor = AppColors.amber;
//        return Border.all(color: AppColors.amber, width: 3);
      default:

        return null;
    }
  }
  Widget get centreWidget{
    switch (widget.status) {
      case ItemStatus.Selected:
        return Icon(Icons.check,size: SizeConfig.mediumIcon,color: AppColors.whiteColor);
      case ItemStatus.Few:
        return Icon(Icons.check,size: SizeConfig.mediumIcon,color: AppColors.whiteColor);
      case ItemStatus.UnAvailable:
        return Icon(Icons.clear,size: SizeConfig.mediumIcon,color: AppColors.whiteColor);
      case ItemStatus.Selected:
        return Stack(
          children: [
            widget.child,
            Positioned.fill(child: Align(alignment: Alignment.center,
                child:
            Icon(Icons.check,size: SizeConfig.mediumIcon,color: AppColors.whiteColor)))
          ],
        );

      default:

        return widget.child;
    }
  }

  @override
  Widget build(BuildContext context) {
    double _margin = widget.minSize != null ? ((widget.minSize.height - widget.size) / 3) : 0;

    return Padding(
      padding: EdgeInsets.all(widget.padding),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: OverflowBox(
          minWidth: widget.minSize?.width,
          minHeight: widget.minSize?.height,
          maxHeight: widget.maxSize?.height,
          maxWidth: widget.maxSize?.width,
          child: SizedBox(
            width: widget.minSize != null ? widget.minSize.width : null,
            height: widget.minSize != null ? widget.minSize.height : null,
            child: Container(
                width: widget.size,
                height: widget.size,
                margin: widget.minSize != null ? EdgeInsets.all(_margin) : null,
                decoration:
                BoxDecoration(shape: BoxShape.circle, gradient: _activeBackgroundColor, border: _activeBorder),
                child: centreWidget
            ),
          ),
        ),
      ),
    );
  }


}
