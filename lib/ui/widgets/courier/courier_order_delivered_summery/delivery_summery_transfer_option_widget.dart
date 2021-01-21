import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order_deleivered_summary.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/custom_radio_widget.dart';

class DeliveryOptionTransferOptionsWidget extends StatefulWidget {
  final CourierOrderDeliveredSummaryViewModel model;

  DeliveryOptionTransferOptionsWidget({this.model});

  @override
  _DeliveryOptionTransferOptionsWidgetState createState() => _DeliveryOptionTransferOptionsWidgetState();
}

class _DeliveryOptionTransferOptionsWidgetState extends State<DeliveryOptionTransferOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.screenWidth * .08),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizeConfig.verticalSpaceSmall(),
          Text(
            AppStrings.SELECT_TRANSFER_METHOD.tr(),
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyText2.color,
                fontSize: SizeConfig.fontSizeLarger,
                fontWeight: FontWeight.bold),
          ),
          SizeConfig.verticalSpaceMedium(),
          CustomRadioWidget(
            isSelected: widget.model.selectedOption == AppStrings.PAYPAL.tr(),
            title: AppStrings.PAYPAL.tr(),
            onTap: () {
              widget.model.onSelectTranferOption(AppStrings.PAYPAL.tr());
              setState(() {});
            },
          ),
          SizeConfig.verticalSpaceMedium(),
          CustomRadioWidget(
            isSelected: widget.model.selectedOption == AppStrings.HANDED_OVER_PERSONALLY.tr(),
            title: AppStrings.HANDED_OVER_PERSONALLY.tr(),
            onTap: () {
              widget.model.onSelectTranferOption(AppStrings.HANDED_OVER_PERSONALLY.tr());
              setState(() {});
            },
          ),
          SizeConfig.verticalSpaceMedium(),
          Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  buttonColor: Theme.of(context).primaryColorLight,
                  buttonText: AppStrings.CANCEL.tr(),
                  textColor: Theme.of(context).focusColor,
                  radius: SizeConfig.smallBorderRadius,
                ),
              ),
              SizeConfig.horizontalSpaceSmall(),
              Expanded(
                child: ButtonWidget(
                    onPressed: () {
                      widget.model.onUpdatePayment();
                    },
                    buttonColor: Theme.of(context).primaryColor,
                    buttonText: AppStrings.OK.tr(),

                    radius: SizeConfig.smallBorderRadius),
              )
            ],
          ),
        ],
      ),
    );
  }
}
