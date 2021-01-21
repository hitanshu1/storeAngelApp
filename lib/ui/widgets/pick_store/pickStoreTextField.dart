import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/pickStore_viewmodel.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';

class PickStoreTextField extends StatelessWidget {
  final TextEditingController searchNearbyStoreController;
  final FocusNode searchNearbyStoreFocusNode;
  final PickStoreViewModel model;

  const PickStoreTextField({Key key,
    @required this.searchNearbyStoreController,
    @required this.searchNearbyStoreFocusNode,
    @required this.model})
      : assert(searchNearbyStoreController != null),
        assert(searchNearbyStoreFocusNode != null),
        assert(model != null),
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.buttonHeight,
      width: SizeConfig.screenWidth * 0.88,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(SizeConfig.borderRadius),
      ),
      child: Center(
        child: TextField(
          controller: searchNearbyStoreController,
          focusNode: searchNearbyStoreFocusNode,
          textInputAction: TextInputAction.done,
          textAlignVertical: TextAlignVertical.center,
          style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: AppConstants.fontSizeSmall),
          onSubmitted: (val){
            FocusScope.of(context).requestFocus(FocusNode());
          },

          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
              hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: AppConstants.fontSizeSmall),
              border: InputBorder.none,
              hintText: AppStrings.SEARCH_FOR_STORE.tr()),
          onChanged: (value) async{
            model.pickTextFieldtext = value;
             bool hasValue = await model.onTextFieldChanged(value);
             if(!hasValue) addStoreDialog(model, context);
          },
        ),
        //  ),
      ),
    );
  }

  addStoreDialog(PickStoreViewModel model, BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor:   Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(SizeConfig.introGetStarted_button_Radius))),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  AppStrings.DIALOG_TITLE_ADD_STORE.tr(),
                  style: AppStyles.BlackStyleFont_20(context),
                  textAlign: TextAlign.center,
                ),
                Text(AppStrings.DO_YOU_WANT_TO_ADD.tr(),
                    style: AppStyles.BlackStyleFont_20(context), textAlign: TextAlign.center),
                SizedBox(height: SizeConfig.introGetStarted_button_Radius,),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: ButtonWidget(
                        buttonText: AppStrings.CANCEL_BUTTON.tr(),
                        buttonColor: AppColors.whiteColor,
                        fontSize: SizeConfig.fontSizeMedium,
                        radius: SizeConfig.introGetStarted_button_Radius,
                        textColor: AppColors.primaryColor,
                        onPressed: () {
                          model.popToScreen();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      flex: 8,
                      child: ButtonWidget(
                        buttonText: AppStrings.PICK_AND_ADD.tr(),
                        buttonColor: AppColors.primaryColor,
                        fontSize: SizeConfig.fontSizeMedium,
                        radius: SizeConfig.introGetStarted_button_Radius,
                        textColor: Colors.white,
                        onPressed: () {
                          model.popToScreen();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
