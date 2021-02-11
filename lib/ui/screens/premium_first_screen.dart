import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/premium_first_screen_viewmodel.dart';
import 'package:storeangelApp/ui/screens/premiumScreen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/widgets/premium_screen/premium_stores_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class PremiumFirstScreen extends StatelessWidget {
  static const String routeName = 'premiumFirstScreen';


  Widget _checkMarkWithText(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .13, vertical: 3),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: AppColors.whiteColor,
            size: SizeConfig.fontSizeMedium * 2,
          ),
          SizeConfig.horizontalSpaceSmall(),
          Expanded(
            child: Text(
              text,
              style: AppStyles.WhiteStyle_Font20.copyWith(
                fontSize: SizeConfig.fontSizeLarger,
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BaseView<PremiumFirstScreenViewModel>(
        onModelReady: (model)=>model.initializeData(),

        builder: (context,model,child){
          if(model.state==ViewState.Busy){
            return AppConstants.circulerProgressIndicator();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                PremiumStoresWidget(stores: model.stores,),
                SizeConfig.verticalSpaceMedium(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: Text(AppStrings.SUPPORT_MORE_LOCAL_BUSINESSES.tr(),
                    style: AppStyles.WhiteStyle_WithBold700_Font20,textAlign: TextAlign.center,),
                ),
                SizeConfig.verticalSpaceMedium(),
                _checkMarkWithText(AppStrings.UNLIMITED_ORDERS_PREMIUM.tr(), context),
                _checkMarkWithText(AppStrings.MULTIPLE_DELIVERY_ADDRESSES.tr(), context),
                _checkMarkWithText(AppStrings.UP_TO_TEN_STORES_PREMIUM.tr(), context),
                _checkMarkWithText(AppStrings.ACCESS_PAST_PURCHASES.tr(), context),
                _checkMarkWithText(AppStrings.ACCESS_TO_PAYMENT_ON_DELIVERY.tr(), context),
                _checkMarkWithText(AppStrings.MORE_NOTIFICATIONS_EVERY_DAY.tr(), context),
                _checkMarkWithText(AppStrings.NO_ADS_PREMIUM.tr(), context),
                SizeConfig.verticalSpaceMedium(),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: ButtonWidget(
                    gradient: AppColors.whiteGradient,
                    textColor: AppColors.primaryColor,
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed(PremiumScreen.routeName);
                    },buttonText: AppStrings.FURTHER_INFORMATION.tr(),),
                ),
                SizeConfig.verticalSpaceMedium(),




              ],
            ),
          );
        },
      ),
    );
  }
}
