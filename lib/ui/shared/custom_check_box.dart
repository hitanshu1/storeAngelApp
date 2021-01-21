import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/enums/available_status.dart';

class CustomCheckBox extends StatefulWidget {
  final double size;
  final bool value;
  final double padding;
  final Size minSize;
  final Size maxSize;
  final double margin;
  final double iconSize;
  final Function onTap;

  CustomCheckBox(
      {this.size: 30, this.onTap,@required this.value, this.minSize, this.maxSize, this.margin, this.padding: 0, this.iconSize});

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> with TickerProviderStateMixin {
  Color _iconColor;

  Color get _activeBackgroundColor {
    switch (widget.value) {
      case true:
        return  AppColors.green;
      default:
        return AppColors.lightGreyColor;
    }
  }

  Border get _activeBorder {
    switch (widget.value) {
      case true:
        _iconColor = AppColors.green;
        return Border.all(color: AppColors.green, width: 3);
      default:
        _iconColor = AppColors.whiteColor;
        return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    double _margin = widget.minSize != null ? ((widget.minSize.height - widget.size) / 3) : 0;

    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
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
                  BoxDecoration(shape: BoxShape.circle, color: _activeBackgroundColor, border: _activeBorder),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
