import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:easy_localization/easy_localization.dart';
class ProfileHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
        builder: (context,profileViewModel,child){
          return SliverToBoxAdapter(
            child:Stack(
              children: [
                SizedBox(
                  height: SizeConfig.headerHeight+(SizeConfig.imageHeight160*.5),
                ),
                AppHeader(
                  height: SizeConfig.headerHeight,
                  title: AppStrings.YOUR_PROFILE.tr(),
                  style: AppStyles.WhiteStyleWithFont24,
                  actions: [
                    TextButton(
                        onPressed: () {
                          profileViewModel.signOut();
                        },
                        child: Text(
                          AppStrings.SIGN_OUT.tr(),
                          style: AppStyles.WhiteStyle_Font20,
                        )),
                  ],
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomCard(
                      radius: SizeConfig.imageHeight160,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.whiteColor)
                        ),
                        child: ViewAppImage(
                          height: SizeConfig.imageHeight160,
                          width: SizeConfig.imageHeight160,
                          imageUrl: profileViewModel.user.imageUrl != null && profileViewModel.user.imageUrl.isNotEmpty
                              ? profileViewModel.user.imageUrl
                              : 'https://firebasestorage.googleapis.com/v0/b/gpat-test.appspot.com/o/sample_profile.png?alt=media&token=5bbcd983-45aa-4c98-8487-1b8a79650ac7',
                          radius: SizeConfig.imageHeight160,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ) ,
          );
        });
  }
}
