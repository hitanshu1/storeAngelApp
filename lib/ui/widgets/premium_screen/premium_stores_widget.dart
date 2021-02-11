import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/app_sample_data.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:easy_localization/easy_localization.dart';

class PremiumStoresWidget extends StatelessWidget {
  final List<StoreDataModel>stores;
  PremiumStoresWidget({this.stores});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color:  Colors.black.withOpacity(.65),
                blurRadius: 10,
                offset: Offset(10,0)
              )
            ]
          ),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: stores.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {

                return ViewAppImage(
                  imageUrl: stores[index].image,
                );
          }),
        ),
        Positioned.fill(child: Align(
          child: Stack(
            children: [
              Padding(
                padding: SizeConfig.sidelargepadding.copyWith(
                  top: 30
                ),
                child: AppShapeItem(
                  color: AppColors.whiteColor.withOpacity(.7),
                  child: Container(
                    height: 87,
                    width: SizeConfig.screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppStrings.TOGETHER_FOR.tr(),style: AppStyles.GrayStyleItalicFont16(context),),
                        SizeConfig.verticalSpaceSmall(),
                        Text(AppStrings.NUMBRECHT.tr(),style: AppStyles.GrayStyleFontWeight500_d24(context).copyWith(
                          fontStyle: FontStyle.italic
                        ),)
                      ],
                    ),

                  ),
                ),
              ),
              Positioned(top: 0,right:5,child: Padding(
                padding: SizeConfig.largerSidepadding,
                child:SvgPicture.asset(AssetsPath.angelHeartSvg),
              )),


            ],
          ),
        )),
        Positioned.fill(child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: SizeConfig.topCPadding,
            child: BackButton(
              color: AppColors.whiteColor,
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
        ))
      ],
    );
  }
}
