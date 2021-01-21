import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_signup_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/search_appbar_widget.dart';

class CourierVerifyScreen extends StatelessWidget {
  static const String routeName = 'courierVerifyScreen';
  @override
  Widget build(BuildContext context) {

    final user=Provider.of<UserModel>(context);
    SizeConfig.sizeConfigInit(context);
    return BaseView<CourierSignUpViewModel>(

      builder: (context,model,child){
        if(model.state==ViewState.Busy){
          return Scaffold(body: AppConstants.circulerProgressIndicator(),);
        }
        return Scaffold(
          appBar: SearchAppBar(
            child: Row(
              children: [
                BackButton(
                  color: Theme.of(context).iconTheme.color,onPressed: (){
                  model.navigatorPop();
                },),
                Expanded(child: Text(AppStrings.VERIFY_ITS_YOU.tr(),
                  style: AppStyles.BlackStyleWithw500_FontC18(context).copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,)),
                SizeConfig.horizontalSpace(SizeConfig.screenWidth*.1),

              ],
            ),
          ),
          body: Padding(
            padding: SizeConfig.sidepadding,
            child: Container(
              width: SizeConfig.screenWidth,
              child: Column(
                children: [
                  Container(
                    width: SizeConfig.screenWidth*.8,
                    child: Text(AppStrings.WE_HAVE_JUST_SENT.tr(),style: AppStyles.BlackStyleWithw500_FontC18(context).copyWith(fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,),
                  ),
                  SizeConfig.CVerticalSpacevEMedium(),
                  Expanded(
                    flex: 8,
                    child: InkWell(
                      child: Container(
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(AppConstants.button_Radius)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(StoreangelIcons.camera_full, size: SizeConfig.screenWidth*.15, color: Theme.of(context).primaryColor,),
                            SizeConfig.CVerticalSpaceMedium25(),
                            Text(AppStrings.TAKE_A_SELFIE_WITH.tr(),
                              style: AppStyles.BlackStyleFont_20(context),
                            textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                      onTap: (){
                        model.openGallery().then((value){
                          model.onSkipVerification(user);
                          /*if(value){
                            Navigator.of(context).pushNamed(SignUpConfirmationScreen.routeName,arguments: model.imageFile);
                          }*/
                        });
                      },
                    ),
                  ),
                  SizeConfig.CVerticalSpace55(),
                  SizedBox(
                    width: SizeConfig.screenWidth*.8,
                    child: Text(AppStrings.YOU_CAN_SKIP_VERIFICATION.tr(),
                      style: AppStyles.GrayStyle_FontMedium(context),textAlign: TextAlign.center,),
                  ),
                  Spacer(flex: 2,),
                  FlatButton(
                      onPressed: (){
                       model.onSkipVerification(user);
                      },
                      child: Text(AppStrings.SKIP_VERIFICATION.tr(),style: AppStyles.GreenStyleWithw500Font_24(context),)),
                  Spacer(flex: 1,),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
