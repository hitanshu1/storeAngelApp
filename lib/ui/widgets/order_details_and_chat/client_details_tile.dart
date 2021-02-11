import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/core/models/participant.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/time_ago_service.dart';
import 'package:storeangelApp/core/viewmodel/view_model_client_details_tile.dart';
import 'package:storeangelApp/ui/screens/courier/courier_item_details_screen.dart';
import 'package:storeangelApp/ui/shared/app_shap_item.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/custom_five_widgets_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/widgets/courier/courier_item_tile_widget.dart';

class ClientDetailsTileWidget extends StatelessWidget {

final  Participant participant;
  ClientDetailsTileWidget({this.participant});
  @override
  Widget build(BuildContext context) {
    return BaseView<ClientDetailsTileViewModel>(
      onModelReady: (model)=>model.initializeValue(participant),
      builder: (context,model,child){
        if(model.state==ViewState.Busy){
          return AppConstants.circulerProgressIndicator();
        }
        return Padding(
          padding: SizeConfig.verticalPadding,
          child: Column(
            children: [
              GestureDetector(
                onTap: model.toggleShowProductList,
                child: CustomFiveWidgetsTile(borderRadius: model.showProduct?SizeConfig.topRightCirShapeRadius:null,
                    trailingOneBackGroundColor: AppColors.grayMediumGradient,
                    trailingTwoBackGroundColor: AppColors.grayMediumGradient,
                    trailingOne: Center(child: Icon(StoreangelIcons.card,
                      color: AppColors.whiteColor,size: SizeConfig.mediumIcon*.6,)),
                    trailingTwo: FittedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '${model.selctedProduct}',
                              style:  AppStyles.WhiteStyle_WithBold900_Font36,
                              children: <TextSpan>[
                                TextSpan(text: '/${participant.products.length}', style: AppStyles.WhiteStyle_WithBold700_Font20),
                              ],
                            ),
                          ),

                          Text(AppStrings.ORDERS.tr(),style: AppStyles.WhiteStyle_FontSmall,)

                        ],
                      ),
                    ),

                    imageUrl: participant.clientDetails.imageUrl,
                    middleWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text(AppStrings.ORDER.tr(),style: AppStyles.BlackStyleFont16Light(context),)),

                            Text(TimeAgoService.timeAgoSinceDate(DateTime.now().subtract(Duration(minutes: 14)), context),
                              style: AppStyles.GrayStyleItalicFont16(context),),

                          ],
                        ),
                        SizeConfig.verticalSpaceSmall(),
                        Text(participant.clientDetails.name,style: AppStyles.BlackStyleWithBold800Font_24(context),),
                        SizeConfig.verticalSpaceSmall(),
                        Text(AppStrings.euroSymbol+NumberService.priceAfterConvert(277, context),style: AppStyles.BlackStyleFont20W300(context),),
                        SizeConfig.verticalSpaceMedium(),
                        Text(participant.clientDetails.twoLineAddress,
                          style: AppStyles.BlackStyleFont16Light(context),)
                      ],
                    )),
              ),
              model.showProduct?AppShapeItem(
                borderRadius: SizeConfig.bottomCircularRadius,
                child: Container(
                  color: Theme.of(context).toggleableActiveColor,
                  child: Padding(
                    padding: SizeConfig.innersidepadding,
                    child: ListView.builder(
                      shrinkWrap: true,
                        itemCount: participant.products.length,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),


                        itemBuilder: (context,int index){
                          return InkWell(
                            onTap: (){
                              model.navigateToScreen(CourierItemDetailsScreen.routeName,
                                  arguments: CourierItemDetailsArguments(
                                    orderByStore: OrderByStore(
                                      participants: [participant]
                                    ),
                                      products: participant.products,
                                      selectedProduct: participant.products[index],
                                      clients: [participant.clientDetails]
                                  ));
                            },
                            child: CourierItemTileWidget(
                              onClickStatus: (){
                                model.onUpdateStatus(participant.products[index]);
                              },
                              enableQuantity: true,
                              isItalicFont: false,
                              editStatus: true,
                              product: participant.products[index],
                              isBorder: index!=participant.products.length-1,
                            ),
                          );
                        }),
                  ),
                ),
              ):Container(),
            ],
          ),
        );
      },
    );
  }
}
