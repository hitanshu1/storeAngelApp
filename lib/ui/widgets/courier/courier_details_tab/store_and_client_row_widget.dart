import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class StoreAndClientRowWidget extends StatelessWidget {
  final StoreDataModel store;
  final UserModel client;

  StoreAndClientRowWidget({@required this.client,@required this.store});
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: SizeConfig.padding,
        child: Row(
          children: [
            Expanded(child: Column(
              children: [
                SizeConfig.verticalSpaceSmall(),
                  ViewAppImage(
                    imageUrl: store.image,
                    height: SizeConfig.smallImageHeight55,
                    width: SizeConfig.smallImageHeight55,
                    radius: 10,
                  ),
                SizeConfig.verticalSpaceSmall(),
                Text(store.name??'',style: AppStyles.BlackStyleWithBold800Font_20(context),),
                SizeConfig.verticalSpaceSmall(),
                Text(store.street??'',style: AppStyles.GrayStyle_Font16(context),),
                SizeConfig.verticalSpaceVerySmall(),
                Text(store.zipCity??'',style: AppStyles.GrayStyle_Font16(context),),
                SizeConfig.verticalSpaceSmall(),
              ],
            )),
            Expanded(child: Column(
              children: [
                SizeConfig.verticalSpaceSmall(),
                ViewAppImage(
                  imageUrl: client.imageUrl,
                  height: SizeConfig.smallImageHeight55,
                  width: SizeConfig.smallImageHeight55,
                  radius: SizeConfig.smallImageHeight55,
                ),
                SizeConfig.verticalSpaceSmall(),
                Text(client.name??'',style: AppStyles.BlackStyleWithBold800Font_20(context),),
                SizeConfig.verticalSpaceSmall(),
                Text(client.street??'',style: AppStyles.GrayStyle_Font16(context),),
                SizeConfig.verticalSpaceVerySmall(),
                Text(client.zipCoden??'',style: AppStyles.GrayStyle_Font16(context),),
                SizeConfig.verticalSpaceSmall(),

              ],
            )),

          ],
        ),
      ),
    );
  }
}
