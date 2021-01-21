import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/checkingAcceptedEmail_viewmodel.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class CheckingAcceptedEmailScreen extends StatelessWidget {
  static const String routeName = 'checkingAcceptedEmailScreen';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    SizeConfig.sizeConfigInit(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: BaseView<CheckingAcceptedEmail>(
        onModelReady: (model) => model.delayFunction(),
        builder: (context, model, child) =>
            Padding(
              padding: EdgeInsets.fromLTRB(SizeConfig.sidepadding.left * 2, 0, SizeConfig.sidepadding.right * 2, 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Consumer<AppThemeViewModel>(
                        builder: (context, appThemeViewModel, child) =>
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: AppColors.primaryGradient
                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(10.0),
                                child: ViewAppImage(
                                    assetUrl:AssetsPath.angelLogo,
                                height: SizeConfig.smallImageHeight60,
                                width: SizeConfig.smallImageHeight60,),
                              ),
                            )),
                    SizeConfig.verticalSpaceBigMedium(),
                    Text(
                      AppStrings.YOUR_SIGN_IN_WAS_SUCCESSFUL.tr(),
                      style: AppStyles.GreenStyleWithBold900Font_36(context),
                      textAlign: TextAlign.center,
                    ),
                  ]),
            ),
      ),
    );
  }
}
