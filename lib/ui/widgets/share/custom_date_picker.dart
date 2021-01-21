import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';

class CustomDatePickerWidget extends StatefulWidget {
  final Function onSelect;
  final DateTime initialDatetime;
  final String bottomText;
  final int minuteInterval;
  final DateTime minimumDate;
  final bool enableAllDate;
  final bool hasMinuteInterval;
  final Widget header;
  final CupertinoDatePickerMode mode;

  CustomDatePickerWidget(
      {this.minuteInterval,
      this.onSelect,
      this.bottomText,
      this.initialDatetime,
      this.minimumDate,
      this.header,
      this.enableAllDate: false,
      this.mode:CupertinoDatePickerMode.dateAndTime,
      this.hasMinuteInterval:true});

  @override
  _CustomDatePickerWidgetState createState() => _CustomDatePickerWidgetState();
}

class _CustomDatePickerWidgetState extends State<CustomDatePickerWidget> {
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() {
      _dateTime = widget.initialDatetime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: SizeConfig.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.screenHeight * .01),
              child: InkWell(
                child: Text(
                  AppStrings.CANCEL.tr(),
                  style: AppStyles.GrayStyle_FontMedium(context),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            widget.header ?? Container(),
            Expanded(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(fontSize: 20, color: Theme.of(context).focusColor),
                  ),
                ),
                child: CupertinoDatePicker(
                    initialDateTime: widget.initialDatetime,
                    minimumDate: widget.minimumDate,
                    mode: widget.mode,
                    minuteInterval:widget.hasMinuteInterval? (widget.minuteInterval ?? 30):1,
                    maximumDate: widget.enableAllDate ? null : widget.minimumDate?.add(Duration(hours: 24)),
                    use24hFormat: true,
                    onDateTimeChanged: (dateTime) {
                      setState(() {
                        _dateTime = dateTime;
                      });
                    }),
              ),
            ),
            SizeConfig.CVerticalSpaceVarySmall(),
            ButtonWidget(
              onPressed: () {
                widget.onSelect(_dateTime);
              },
              buttonText: widget.bottomText,
              fontSize: 17,
              radius: 10,
              buttonColor: Theme.of(context).primaryColor,
            ),
            SizeConfig.CVerticalSpacevEMedium(),
          ],
        ),
      ),
    );
  }
}
