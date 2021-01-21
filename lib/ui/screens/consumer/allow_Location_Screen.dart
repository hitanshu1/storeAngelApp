import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/allowLocation_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/googleMapsFindAddress_viewModel.dart';
import 'package:storeangelApp/ui/screens/consumer/pick_Store_Screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/circuler_button_widget.dart';


class AllowLocationScreen extends StatefulWidget {
  static const String routeName = 'allowLocation';

  @override
  State<StatefulWidget> createState() {
    return _AllowLocation();
  }

  
}

class _AllowLocation extends State<AllowLocationScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.sizeConfigInit(context);
    final theme=Theme.of(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: theme.backgroundColor,
          body: Container(
            margin: EdgeInsets.only(left: SizeConfig.screenWidth * 0.08, right: SizeConfig.screenWidth * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Spacer(flex: 3,),
                Container(
                  padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.06, right: SizeConfig.screenWidth * 0.06),
                  child: Text(
                    AppStrings.ACCESS_YOUR_LOCATION.tr(),
                    style: AppStyles.BlackStyleWithBold_FontC18(context),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizeConfig.verticalSpaceMedium(),
                Text(
                  AppStrings.ALLOW_APP_TO_ACCESS_YOUR_LOCATION.tr(),
                  style: AppStyles.BlackStyleFont_20(context).copyWith(fontSize: SizeConfig.fontSizeLarge),
                  textAlign: TextAlign.center,
                ),
                Spacer(flex: 2,),
                Consumer<GoogleMapsFindAddressModel>(
                  builder: (context, model, child) => CircularButtonWidget(
                    buttonText: AppStrings.ALLOW_BUTTON.tr(),
                    buttonColor: Theme.of(context).primaryColor,
                    fontSize: SizeConfig.fontSizeMedium,
                    radius: SizeConfig.borderRadius,
                    textColor: Colors.white,
                    onPressed: () {
                      model.getLocation(true);
                    },
                  ),
                ),
                SizeConfig.verticalSpaceMedium(),
                Consumer<GoogleMapsFindAddressModel>(
                  builder: (context, model, child) => CircularButtonWidget(
                    gradient: AppColors.blackGradient,
                    buttonColor: Theme.of(context).cardColor,
                    buttonText: AppStrings.DONT_Allow_BUTTON.tr(),

                    fontSize: SizeConfig.fontSizeMedium,
                    radius: SizeConfig.borderRadius,
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      model.navigateToScreen(PickStoreScreen.routeName);
                    },
                  ),
                ),
                SizeConfig.verticalSpaceLarge(),
              ],
            ),
          ),
        ),
        Consumer<GoogleMapsFindAddressModel>(
          builder: (context, googleMapsFindAddressViewModel, child){
            return googleMapsFindAddressViewModel.state==ViewState.Busy?Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ):Container();
          },
        )
      ],
    );
  }
}
