import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/ui/shared/search_appbar_widget.dart';

class AssureScreen extends StatelessWidget {
  static const String routeName = 'assureScreen';
  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Gray,context);
    final profileModel=Provider.of<ProfileViewModel>(context);
    return Scaffold(
      appBar: SearchAppBar(
        child: Row(
          children: [
            BackButton(
              color: Theme.of(context).iconTheme.color,
              onPressed: (){
                profileModel.changeView(ProfilePageView.home);
              },
            ),
            Expanded(child: Text(AppStrings.ASSURE.tr(),
              style: AppStyles.BlackStyleWithBold800Font_24(context),
              textAlign: TextAlign.center,)),
            Opacity(
              opacity: 0,
              child: BackButton(
                color: Theme.of(context).iconTheme.color,
                onPressed: (){

                },
              ),
            ),

          ],
        ),
      ),

    );
  }
}
