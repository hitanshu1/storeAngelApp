import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/app_sample_data.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/viewmodel/common_itemsscreen_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_last_item_package.dart';
import 'package:storeangelApp/ui/screens/consumer/landing_Screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/widgets/home/horizontal_list_widget.dart';

class LastItemPackageScreen extends StatefulWidget {
  final Function onClickPush;
  static const String routeName = 'lastItemPackageScreen';
  final Function onChangeBlurValue;
  final List<Product> products;

  LastItemPackageScreen({this.onChangeBlurValue, this.products,this.onClickPush});

  @override
  _LastItemPackageScreenState createState() => _LastItemPackageScreenState();
}

class _LastItemPackageScreenState extends State<LastItemPackageScreen> {
  bool showBill = false;

  List<Widget> dotWidget(BuildContext context) {
    List<Widget> listWidget = [];
    int length = 10;
    for (int i = 0; i < length; i++) {
      listWidget.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: 9 == i ? Theme.of(context).primaryColor : Theme.of(context).primaryColorDark,
          ),
        ),
      );
    }

    return listWidget;
  }

  bool blurScreen = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CommonItemScreenViewModel>(context, listen: false).clearFileImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final commonItemScreenProvider = Provider.of<CommonItemScreenViewModel>(context);
    return BaseView<LastItemPackageViewModel>(
      builder: (context, model, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.sidepadding.left,
              right: SizeConfig.sidepadding.right,
              top: SizeConfig.verticalMedPadding.top
            ),
            child: Column(
              children: [
                Text(
                  AppStrings.CONGRATULATION.tr(),
                  style: AppStyles.GreenStyleWithBold700Font_36(context),
                ),
                SizeConfig.verticalSpace(SizeConfig.screenHeight*.004),
                Text(
                  AppStrings.YOU_HAVE_FINISHED_YOUR_PURCHASE.tr(),
                  textAlign: TextAlign.center,
                  style: AppStyles.BlackStyleNormal_FontC18(context),
                ),
                SizeConfig.verticalSpace(SizeConfig.screenHeight*.004),
                Row(
                  children: [
                    Opacity(
                      opacity: 0,
                      child: InkWell(
                        child: Image.asset(AssetsPath.addBlack),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: Text(
                        AppStrings.PLEASE_TAKE_A_PHOTO_OF_THE_RECEIPT.tr(),
                        style: AppStyles.BlackStyleWithBold_FontC18(context),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Opacity(
                      opacity: commonItemScreenProvider.lastItemFileimages.length > 0 ? 1 : 0,
                      child: InkWell(
                        child: Image.asset(
                          AssetsPath.addBlack,
                          color: Theme.of(context).focusColor,
                        ),
                        onTap: () {
                          commonItemScreenProvider.openGallery(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizeConfig.verticalSpace(SizeConfig.screenHeight*.02),
                SizedBox(
                  height: SizeConfig.screenHeight*.25,
                  child: InkWell(
                    onTap: () {
                      if (commonItemScreenProvider.lastItemFileimages.length > 0) {
                        setState(() {
                          widget.onChangeBlurValue(true);
                        });
                      }
                    },
                    child: commonItemScreenProvider.lastItemFileimages.length > 0
                        ? Container(
                            height: SizeConfig.screenHeight * .3,
                            width: SizeConfig.screenWidth,
                            child: ListView.builder(
                                itemCount: commonItemScreenProvider.lastItemFileimages.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, int index) {
                                  return Container(
                                    height: SizeConfig.screenHeight * .3,
                                    width: SizeConfig.screenWidth * .88,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      image: DecorationImage(
                                          image: FileImage(commonItemScreenProvider.lastItemFileimages[index]),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(SizeConfig.borderRadius),
                                    ),
                                    child: Column(
                                      children: [
                                        SizeConfig.verticalSpaceSmall(),
                                        Padding(
                                          padding: SizeConfig.sidepadding,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                  height: SizeConfig.iconSize,
                                                  child: Image.asset(
                                                    AssetsPath.gallery,
                                                  )),
                                              SizeConfig.horizontalSpaceSmall(),
                                              Expanded(
                                                  child: Text(
                                                '${commonItemScreenProvider.lastItemFileimages.length}',
                                                style: AppStyles.BlackStyleFont_c16(context),
                                              )),
                                              InkWell(
                                                  child: Icon(Icons.delete),
                                                  onTap: () {
                                                    commonItemScreenProvider.onRemoveImage(index);
                                                  })
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        : Container(
                            height: SizeConfig.screenHeight * .3,
                            width: SizeConfig.screenWidth,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(SizeConfig.borderRadius),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: SizeConfig.screenHeight * .3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              child: Icon(
                                            StoreangelIcons.compact_camera,
                                            size: SizeConfig.screenHeight * .05,
                                            color: Theme.of(context).focusColor,
                                          )),
                                          SizeConfig.CVerticalSpacevMedium(),
                                          Text(
                                            AppStrings.TAKE_PHOTO.tr(),
                                            style: AppStyles.BlackStyle_Font12(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      commonItemScreenProvider.openCamera(context);
                                    },
                                  ),
                                ),
                                Container(
                                  color: AppColors.veryLightGrayColor,
                                  width: 1,
                                  height: SizeConfig.screenHeight * .3,
                                ),
                                Expanded(
                                  child: InkWell(
                                    child: Container(
                                      height: SizeConfig.screenHeight * .3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            StoreangelIcons.photos,
                                            size: SizeConfig.screenHeight * .05,
                                            color: Theme.of(context).focusColor,
                                          ),
                                          SizeConfig.CVerticalSpacevMedium(),
                                          Text(AppStrings.CHOOSE_FROM_GALLERY.tr(),
                                              style: AppStyles.BlackStyle_Font12(context)),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      commonItemScreenProvider.openGallery(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                SizeConfig.verticalSpace(SizeConfig.screenHeight*.02),
                Divider(
                  color: Theme.of(context).textTheme.headline3.color,
                ),
                SizeConfig.verticalSpace(8),
                Text(
                  AppStrings.NOTIFICATION_PREVIEW.tr(),
                  style: AppStyles.LightBlackStyleNormal_FontC18(context).copyWith(
                      color: Theme.of(context).textTheme.subtitle2.color, fontSize: SizeConfig.fontSizeMedium),
                ),
                SizeConfig.verticalSpace(4),
                SizedBox(
                  height: 160,
                  child: HorizontalListItemWidget(purchaseDetails: AppSampleData.purchaseDetails),
                ),
                SizeConfig.verticalSpaceMedium(),
                Text(
                  AppStrings.LAST_PAGE_DISCLAIMER.tr(),
                  style: AppStyles.GrayStyleWithBold500_Font16(context)
                      .copyWith(color: Theme.of(context).textTheme.headline3.color),
                  textAlign: TextAlign.center,
                ),
                SizeConfig.verticalSpaceMedium(),
                commonItemScreenProvider.state == ViewState.Busy
                    ? Container()
                    : Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth * .0,
                      right: SizeConfig.screenWidth * .0,
                      bottom: SizeConfig.screenHeight * .04),
                  child: ButtonWidget(
                      radius: AppConstants.button_Radius,
                      fontSize: AppConstants.fontSizeSmall,
                      buttonColor: Theme.of(context).primaryColor,
                      buttonText: AppStrings.POST_NOTIFICATION.tr(),
                      onPressed: () {
                        if(widget.onClickPush!=null){
                          widget.onClickPush();
                        }else{
                          commonItemScreenProvider.addToOrderList();
                          model.navigateToScreen(LandingScreen.routeName);
                        }
                      }),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
