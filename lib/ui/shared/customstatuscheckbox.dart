import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/enums/available_status.dart';

class CustomStatusCheckBox extends StatefulWidget {
  final double size;
  final AvailableStatus status;
  final double padding;
  final Size minSize;
  final Size maxSize;
  final double margin;
  final double iconSize;
  final Widget child;

  CustomStatusCheckBox(
      {this.size: 30, @required this.status, this.minSize, this.maxSize, this.margin, this.padding: 0, this.iconSize,this.child});

  @override
  _CustomStatusCheckBoxState createState() => _CustomStatusCheckBoxState();
}

class _CustomStatusCheckBoxState extends State<CustomStatusCheckBox> with TickerProviderStateMixin {
  AvailableStatus status = AvailableStatus.inactive;
  Color _iconColor;

  Color get _activeBackgroundColor {
    switch (status) {
//      case AvailableStatus.inactive:
//        return AppColors.lightGreyColor;
//      case AvailableStatus.plenty:
//        return AppColors.green;
//      case AvailableStatus.few:
//        return AppColors.amber;
//      case AvailableStatus.runOut:
//        return AppColors.red;
//      case AvailableStatus.unknown:
//        return Colors.transparent;
      case AvailableStatus.selected:
        return AppColors.green;
      default:
        return Colors.transparent;
    }
  }

  Border get _activeBorder {
    switch (status) {
      case AvailableStatus.selected:
        _iconColor = AppColors.green;
        return Border.all(color: AppColors.green, width: 3);
      case AvailableStatus.unknown:
        _iconColor = Colors.transparent;
        return Border.all(color: Colors.transparent, width: 3);
      default:
        _iconColor = Colors.transparent;
          return Border.all(color: AppColors.availableStatusColor(status), width: 3);;
    }
  }

  @override
  void initState() {
    super.initState();
    status = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    double _margin = widget.minSize != null ? ((widget.minSize.height - widget.size) / 3) : 0;

    return GestureDetector(
      onTap: onTap,
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
                  child: status != AvailableStatus.selected
                      ? Container(child: widget.child!=null?widget.child:Container(),
                  )
                      : Icon(
                          Icons.check,
                          color: AppColors.whiteColor,
                          size: widget.iconSize,
                        )),
            ),
          ),
        ),
      ),
    );
  }

  void onTap() {
    switch (status) {
      case AvailableStatus.selected:
        status=AvailableStatus.plenty;
        break;
      case AvailableStatus.inactive:
        status = AvailableStatus.plenty;
        break;
      case AvailableStatus.plenty:
        status = AvailableStatus.few;
        break;
      case AvailableStatus.few:
        status = AvailableStatus.runOut;
        break;
      case AvailableStatus.runOut:
        status = AvailableStatus.unknown;
        break;
      case AvailableStatus.unknown:
        status = AvailableStatus.selected;
        break;
    }
    setState(() {});
  }
}
