import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/notification_type.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/core/viewmodel/home_viewmodel.dart';
import 'package:storeangelApp/ui/screens/consumer/share_notification_screen.dart';
import 'package:storeangelApp/ui/screens/purchase_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_order/item_available_widget.dart';

class InFormationInspireWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(builder: (context,model,child){
      if(model.state==ViewState.Busy){
        return AppConstants.circulerProgressIndicator();
      }
      return SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.primaryColor
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizeConfig.verticalSpaceSmall(),
              Padding(
                padding: SizeConfig.sidepadding,
                child: TitleTextWidget(title: AppStrings.LET_YOURSELF_BE_INFORMED_AND_INSPIRED.tr(),
                  color: AppColors.whiteColor,),
              ),
              SizeConfig.verticalSpaceSmall(),
              model.inspireList.length>0?
              Padding(
                padding: SizeConfig.sidepadding,
                child: CarouselSlider.builder(
                    options: CarouselOptions(
                        autoPlay: true,
                        disableCenter: true,
                        autoPlayInterval: Duration(seconds: 10),
                        height: SizeConfig.tileHeight,
                        viewportFraction: 1,
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          model.setSelectedIndex(index);
                        }
                    ),
                    itemCount: model.inspireList.length,
                    itemBuilder: (context, index) {
                      return InkWell(

                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: CustomFiveWidgetsTile(
                              trailingTwoBackGroundColor: AppColors.primaryGradient,
                              trailingOneBackGroundColor: AppColors.primaryGradient,
                              trailingOne:  FittedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('9',style: AppStyles.WhiteStyle_WithBold900_Font36,),
                                    Text(AppStrings.ARTICLES.tr(),style: AppStyles.WhiteStyle_FontSmall,)
                                  ],
                                ),
                              ),
                              enableTrailingTwoPadding: false,
                              trailingTwo: FittedBox(
                                fit: BoxFit.cover,
                                child: ViewAppImage(
                                  imageUrl: model.inspireList[index].storeDetails.image,
                                ),
                              ),
                              imageUrl: model.inspireList[index].customer.imageUrl,
                              middleWidget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizeConfig.verticalSpaceSmall(),
                                  Row(
                                    children: [
                                      Expanded(child: Text(AppStrings.PURCHASING.tr(),style: AppStyles.BlackStyleFont16Light(context),)),
                                      Text(TimeAgoService.timeAgoSinceDate(model.inspireList[index].time, context),
                                        style: AppStyles.GrayStyleItalicFont16(context),),

                                    ],
                                  ),
                                  SizeConfig.verticalSpaceSmall(),
                                  Text(model.inspireList[index].listName,style: AppStyles.BlackStyleWithBold800Font_20(context),),
                                  SizeConfig.verticalSpaceSmall(),

                                  ItemAvailableWidget(products: model.inspireList[index].products,),
                                  SizeConfig.verticalSpaceMedium(),
                                  Text(model.inspireList[index].customer.name,style: AppStyles.BlackStyleFont300_16(context),),
                                  Text(model.inspireList[index].customer.addressLines,
                                    style: AppStyles.BlackStyleFont16Light(context),),
                                  SizeConfig.verticalSpaceSmall(),
                                ],
                              )),
                        ),
                        onTap: ()async{
                          if (model.inspireList[index].notificationType == NotificationType.shareNotification.notificationValue) {
                            await Navigator.of(context)
                                .pushNamed(ShareNotificationScreen.routeName, arguments: model.inspireList[index])
                                .then((value) {});
                          } else {
                            StatusBarService.changeStatusBarColor(StatusBarType.DoubleGray, context);
                            await Navigator.of(context).pushNamed(PurchaseScreen.routeName, arguments: model.inspireList[index]);
                            StatusBarService.changeStatusBarColor(StatusBarType.Gray, context);
                          }
                        },
                      );
                    }),
              ):Text(AppStrings.THERE_ARE_NO_PURCHASES_ON.tr(),
                style: AppStyles.WhiteStyle_Font20,
                textAlign: TextAlign.center,),
              model.inspireList.length>0?Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: model.inspireList.map((url) {
                    int index = model.inspireList.indexOf(url);
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: model.selectedIndex == index
                            ? AppColors.whiteColor
                            : Theme.of(context).primaryColorLight,
                      ),
                    );
                  }).toList(),
                ),
              ):Container(),
            ],
          ),
        ),
      );
    });
  }
}
