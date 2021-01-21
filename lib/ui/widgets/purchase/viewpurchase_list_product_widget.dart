import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/ui/shared/status_dot.dart';
import 'package:storeangelApp/ui/widgets/purchase/purchase_checkbox.dart';

class ViewPurchaseListProductWidget extends StatefulWidget {
  final Product product;
  final Function(PurchaseCheckBoxStatus) onTapWithStatus;

  ViewPurchaseListProductWidget({this.product, this.onTapWithStatus});

  @override
  _ViewPurchaseListProductWidgetState createState() => _ViewPurchaseListProductWidgetState();
}

class _ViewPurchaseListProductWidgetState extends State<ViewPurchaseListProductWidget> {
  PurchaseCheckBoxStatus status = PurchaseCheckBoxStatus.Unselected;

  @override
  void initState() {
    super.initState();
    status = widget.product.wishList.contains('userID-1')
        ? PurchaseCheckBoxStatus.AlreadyListed
        : PurchaseCheckBoxStatus.Unselected;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Theme.of(context).primaryColorLight))),
        child: Padding(
          padding: SizeConfig.verticalLarPadding,
          child: Row(
            children: [
              PurchaseCheckBox(
                  status: status),
              SizeConfig.horizontalSpaceSmall(),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: '${widget.product.name} ',
                    style: AppStyles.BlackStyleFontWeight500_13(context),
                  ),
                ),
              ),
              SizeConfig.horizontalSpaceSmall(),
              Text('${widget.product.quantity}', style: AppStyles.BlackStyleFontWeightSmall_12(context)),
              SizeConfig.horizontalSpaceSmall(),
              StatusDot(
                availableStatus: widget.product.availableStatus,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onTap() {
    switch (status) {
      case PurchaseCheckBoxStatus.Unselected:
        status = PurchaseCheckBoxStatus.Selected;
        break;
      case PurchaseCheckBoxStatus.Selected:
        status = PurchaseCheckBoxStatus.Unselected;
        break;
      case PurchaseCheckBoxStatus.AlreadyListed:
        break;
    }
    if(widget.onTapWithStatus!=null)widget.onTapWithStatus(status);
    setState(() {});
  }
}
