import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';
import 'package:storeangelApp/ui/shared/showbottomSheet.dart';
import 'package:storeangelApp/ui/widgets/share/custom_date_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class AppDeliveryPeriodTileWidget extends StatefulWidget {
  final String title;
  final String hintText;
  final Function onChangeDateTime;
  AppDeliveryPeriodTileWidget({@required this.title,@required this.hintText,@required this.onChangeDateTime});

  @override
  _AppDeliveryPeriodTileWidgetState createState() => _AppDeliveryPeriodTileWidgetState();
}

class _AppDeliveryPeriodTileWidgetState extends State<AppDeliveryPeriodTileWidget> {


  DateTime startDate;
  String selectDateAndTime;

  void _onTapSelectDate(BuildContext context) {
    DateTime now = DateTime.now();
    int minuteDifference = now.minute != 0 ? 60 - now.minute : 0;
    DateTime initialDate = now.add(Duration(hours: 2, minutes: minuteDifference));
    ShowBottomSheet.showLarge(
        child: CustomDatePickerWidget(
          minuteInterval: 1,
          initialDatetime: initialDate,
          bottomText: AppStrings.NEXT_SELECT_END_TIME.tr(),
          onSelect: (dateTime) {
            setState(() {
              startDate=dateTime;
            });
            if (dateTime != null) {
              Navigator.pop(context);
              ShowBottomSheet.showLarge(
                  child: CustomDatePickerWidget(
                    minuteInterval: 1,

                    initialDatetime: startDate.add(Duration(hours: 2)),
                    bottomText: AppStrings.DELIVERY_UNTIL.tr(),

                    minimumDate: startDate.add(Duration(hours: 2)),
                    onSelect: (dateTime) {
                      if (dateTime != null) {
                        //
                        selectDateAndTime =
                        '${startDate.day}. ${AppConstants.getMonth(startDate.month)} ${startDate.hour < 10 ? '0${startDate.hour}' : startDate.hour}:${startDate.minute < 10 ? '0${startDate.minute}' : startDate.minute} - ${dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour}:${dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute}';
                        setState(() {

                        });
                        widget.onChangeDateTime(selectDateAndTime);
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  context: context,
                  heightFactor: .4);
            }
          },
        ),
        context: context,
        heightFactor: .4);
  }

  @override
  Widget build(BuildContext context) {
    return AppShapeItem(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).toggleableActiveColor
        ),
        child: Padding(
          padding: SizeConfig.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title,style:AppStyles.BlackStyleWithBold800Font_20(context),),
              SizeConfig.verticalSpaceSmall(),
              InkWell(
                onTap: (){
                  _onTapSelectDate(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(SizeConfig.radiusSmall)
                  ),
                  child: Padding(
                    padding: SizeConfig.padding,
                    child: Center(child: Text(selectDateAndTime??widget.hintText,style: AppStyles.GrayStyle_Font16(context),),),
                  ),
                ),
              ),
              SizeConfig.verticalSpaceSmall(),
            ],
          ),
        ),
      ),
    );
  }
}
