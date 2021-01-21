import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/ui/screens/premiumScreen.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class PremiumCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final EdgeInsets padding;
  final TextStyle titleStyle, subtitleStyle;
  final double imageHeight;

  PremiumCard({this.title, this.subtitle, this.padding, this.subtitleStyle, this.titleStyle, this.imageHeight});

  @override
  Widget build(BuildContext context) {
    bool imageHeightIsNotNull = imageHeight != null;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, PremiumScreen.routeName);
      },
      child: AppShapeItem(
        child: Container(
          decoration: BoxDecoration(
              gradient: AppColors.primaryGradient
          ),
          child: Padding(
            padding:SizeConfig.paddingWithHighVerticalSpace,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizeConfig.horizontalSpaceSmall(),
                ViewAppImage(
                  width: SizeConfig.smallImageHeight60,
                  height: SizeConfig.smallImageHeight60,
                  assetUrl: AssetsPath.gift,

                ),
                SizeConfig.horizontalSpaceSmall(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: SizeConfig.screenWidth*.5,
                        child: AutoSizeText(
                          title,
                          maxLines: 2,
                          minFontSize: 10,
                          maxFontSize: SizeConfig.fontSizeLarge,
                          style: titleStyle != null ? titleStyle : AppStyles.WhiteStyle_WithBold700_Font20,
                        ),
                      ),
                      SizeConfig.CVerticalSpaceVarySmall(),
                      Text(
                        subtitle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: subtitleStyle != null ? subtitleStyle : AppStyles.WhiteStyle_Font20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
