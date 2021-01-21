import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';

enum PurchaseCheckBoxStatus{AlreadyListed,Selected,Unselected}

class PurchaseCheckBox extends StatefulWidget {
  final double size;
  final PurchaseCheckBoxStatus status;
  final double padding;
  final double margin;

  PurchaseCheckBox({this.size: 20, @required this.status, this.margin,this.padding:0});

  @override
  _PurchaseCheckBoxState createState() => _PurchaseCheckBoxState();
}

class _PurchaseCheckBoxState extends State<PurchaseCheckBox> with TickerProviderStateMixin {

  Border get _activeBorder {
    switch (widget.status) {
      case PurchaseCheckBoxStatus.Unselected:
        return Border.all(color: AppColors.primaryColor);
      default:
        return null;
    }
  }

  Color get _activeBackgroundColor {
    switch (widget.status) {
      case PurchaseCheckBoxStatus.AlreadyListed:
        return AppColors.primaryColor.withOpacity(.4);
      case PurchaseCheckBoxStatus.Selected:
        return AppColors.primaryColor;
      case PurchaseCheckBoxStatus.Unselected:
        return Colors.transparent;
      default:
        return Colors.transparent;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(widget.padding),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration( color: _activeBackgroundColor, border: _activeBorder,
            borderRadius: BorderRadius.circular(widget.size*.3)),
            child: widget.status==PurchaseCheckBoxStatus.Unselected?Container():Icon(
              Icons.check,
              color: AppColors.whiteColor,
              size: widget.size*.8,
            )),
      ),
    );
  }
}
