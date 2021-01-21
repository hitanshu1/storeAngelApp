import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/ui/shared/circuler_button_widget.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/watchlist/viewwatch_item.dart';

class ShareNotificationScreen extends StatefulWidget {
  static const String routeName = 'shareNotificationScreen';
  final PurchaseDetails purchaseDetails;
  ShareNotificationScreen({this.purchaseDetails});

  @override
  _ShareNotificationScreenState createState() => _ShareNotificationScreenState();
}

class _ShareNotificationScreenState extends State<ShareNotificationScreen> {
  final ScrollController _scrollController = ScrollController();
  bool hasShadow = false;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    initialize(_scrollController);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: hasShadow?4:0,
        leading: BackButton(
          color: Theme.of(context).iconTheme.color,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              SizeConfig.verticalSpaceSmall(),
              Center(
                child: ViewAppImage(
                  imageUrl: widget.purchaseDetails.customer.imageUrl,
                  height: SizeConfig.BigImageheight,
                  width: SizeConfig.BigImageheight,
                  radius: SizeConfig.BigImageheight,
                ),
              ),
              SizeConfig.CVerticalSpacevEMedium(),
              Text(widget.purchaseDetails.customer.name,style: AppStyles.BlackStyleWithBold800Font_20(context),
                textAlign: TextAlign.center,),
              SizeConfig.verticalSpaceSmall(),
              Text(AppStrings.SHARED_A_LIST_WITH_YOU.tr(), style: AppStyles.BlackStyleFontWeightSmall_20(context), textAlign: TextAlign.center),
              SizeConfig.verticalSpace(20),

              Text(AppConstants.getTimeString(widget.purchaseDetails.time),style: AppStyles.GrayStyle_Font16(context),
                  textAlign: TextAlign.center),
              SizeConfig.CVerticalSpacevEMedium(),
              Padding(
                padding: SizeConfig.padding,
                child: WatchListItem(item: widget.purchaseDetails, showHireCourierButton: false,),
              ),
              SizeConfig.CVerticalSpaceExtra110(),


            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: SizeConfig.bottomsidePadding,
              child: Row(
                children: [
                  Expanded(
                    child: CircularButtonWidget(
                        radius: 15,
                        buttonColor: Theme.of(context).cardColor,
                        textColor:Theme.of(context).focusColor,
                        fontSize: SizeConfig.fontSizeLarge,
                        buttonText: AppStrings.DECLINE.tr(), onPressed: (){

                    }),
                  ),
                  SizeConfig.horizontalSpaceSmall(),
                  Expanded(
                    child: CircularButtonWidget(
                        radius: 15,
                        buttonColor: AppColors.primaryColor,
                        fontSize: SizeConfig.fontSizeLarge,
                        textColor: Theme.of(context).cardColor,
                        buttonText: AppStrings.TAKE.tr(), onPressed: (){

                    }),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void initialize(ScrollController scrollController){
    Future.delayed(Duration.zero,(){
      _scrollController.addListener(addScrollListener);
    });
  }

  void addScrollListener(){
    if(_scrollController.position.pixels==0){
      hasShadow = false;
    }else{
      hasShadow = true;
    }
    setState(() {

    });
  }
}
