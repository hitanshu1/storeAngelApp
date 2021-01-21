import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/services/date_service.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/services/string_service.dart';
import 'package:storeangelApp/core/viewmodel/view_model_checkout.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/shared/custom_divider_widget.dart';
import 'package:storeangelApp/ui/shared/custom_flexible_space_widget.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/checkout_productview.dart';
import 'package:storeangelApp/ui/widgets/share/floating_action_animation.dart';

class CourierCheckOutScreen extends StatefulWidget {
  final CheckOutPageArgument argument;
  static const String routeName = 'checkOutScreen';

  CourierCheckOutScreen({this.argument});

  @override
  _CourierCheckOutScreenState createState() => _CourierCheckOutScreenState();
}

class _CourierCheckOutScreenState extends State<CourierCheckOutScreen> {
  var radius = SizeConfig.radiusOfSliverAppbar;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_isAppBarExpanded) {
        setState(() {
          radius = 0.0;
        });
      } else {
        setState(() {
          radius = SizeConfig.radiusOfSliverAppbar;
        });
      }
    });
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients && _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    StatusBarService.changeStatusBarColor(StatusBarType.OffGray, context);
    return BaseView<CheckOutViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          body: model.state == ViewState.Busy
              ? AppConstants.circulerProgressIndicator()
              : CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    CustomSliverAppBar(
                      backgroundColor: theme.cardColor,
                      pinned: true,
                      floating: false,
                      leading: BackButton(
                        color: Theme.of(context).iconTheme.color,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      title: Text(
                        AppStrings.CHECKOUT.tr(),
                        style: AppStyles.BlackStyleWithBold800Font_24(context),
                      ),
                      centerTitle: true,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius))),
                      flexibleSpace: FlexibleSpaceBar(
                        background: CustomFlexibleSpaceWidget(
                          scrollController: _scrollController,
                          child: Column(
                            children: [
                              SizedBox(height: AppBar().preferredSize.height + MediaQuery.of(context).padding.top),
                              Spacer(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).toggleableActiveColor,
                                      borderRadius: BorderRadius.circular(AppConstants.button_Radius)),
                                  padding: SizeConfig.mediumCPadding,
                                  child: IntrinsicHeight(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: ViewAppImage(
                                              radius: 10,
                                              boxFit: BoxFit.fitHeight,
                                              imageUrl:
                                                  widget.argument.orderOrPurchases.purchaseDetails.storeDetails.image,
                                            ),
                                          ),
                                        ),
                                        SizeConfig.horizontalSpaceSmall(),
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.argument.orderOrPurchases.purchaseDetails.storeDetails.name,
                                                style: AppStyles.BlackStyleWithBold800Font_24(context),
                                              ),
                                              Expanded(child: SizeConfig.verticalSpace(SizeConfig.screenHeight * .002)),
                                              Text(
                                                widget.argument.orderOrPurchases.purchaseDetails.storeDetails.street,
                                                style: AppStyles.GrayStyle_Font16(context),
                                              ),
                                              Text(
                                                widget.argument.orderOrPurchases.purchaseDetails.storeDetails.zipCity,
                                                style: AppStyles.GrayStyle_Font16(context),
                                              ),
                                              Expanded(
                                                  flex: 3,
                                                  child: SizeConfig.verticalSpace(SizeConfig.screenHeight * .002)),
                                              Row(
                                                children: [
                                                  Text('300 m', style: AppStyles.BlackStyleFont_16(context)),
                                                  Container(
                                                      height: 16,
                                                      child: VerticalDivider(color: AppColors.darkGrayColor)),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          StoreangelIcons.profile_consumer_tab,
                                                          color: Theme.of(context).focusColor,
                                                          size: AppStyles.BlackStyleFont_16(context).fontSize,
                                                        ),
                                                        SizeConfig.horizontalSpace(5),
                                                        Text('1230', style: AppStyles.BlackStyleFont_16(context))
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                      expandedHeight: SizeConfig.adaptiveHeight(SizeConfig.screenHeight * .2),
                    ),
                    SliverPadding(
                      padding: SizeConfig.sidepadding,
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          if (index == 0) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizeConfig.CVerticalSpacevMedium(),
                                Padding(
                                  padding: SizeConfig.padding,
                                  child: Text(
                                    AppStrings.DELIVERY_PERIOD.tr(),
                                    style: AppStyles.GrayStyle_Font16(context),
                                  ),
                                ),
                                Padding(
                                  padding: SizeConfig.sidepadding,
                                  child: Text(
                                    AppStrings.AS_SOON_AS_POSSIBLE.tr(),
                                    style: AppStyles.BlackStyleWithBold700Font_16(context),
                                  ),
                                ),
                                SizeConfig.CVerticalSpacevMedium(),
                                Padding(
                                  padding: SizeConfig.padding,
                                  child: Text(
                                    AppStrings.DELIVERY_ADDRESS.tr(),
                                    style: AppStyles.GrayStyle_Font16(context),
                                  ),
                                ),
                                Padding(
                                  padding: SizeConfig.sidepadding,
                                  child: Text(
                                    '${widget.argument.orderOrPurchases.purchaseDetails.storeDetails.fullAddress}',
                                    style: AppStyles.BlackStyleWithBold700Font_16(context).copyWith(height: 1.4),
                                  ),
                                ),
                                SizeConfig.CVerticalSpacevMedium(),
                                Padding(
                                  padding: SizeConfig.padding,
                                  child: Text(
                                    AppStrings.DELIVERY.tr() + ':',
                                    style: AppStyles.GrayStyle_Font16(context),
                                  ),
                                ),
                                Padding(
                                  padding: SizeConfig.sidepadding,
                                  child: Text(
                                    AppStrings.DIRECT_HAND_OVER.tr(),
                                    style: AppStyles.BlackStyleWithBold700Font_14(context),
                                  ),
                                ),
                                SizeConfig.CVerticalSpacevMedium(),
                                Padding(
                                  padding: SizeConfig.padding,
                                  child: Text(
                                    AppStrings.ORDER_PAYMENT.tr() + ":",
                                    style: AppStyles.GrayStyle_Font16(context),
                                  ),
                                ),
                                Padding(
                                  padding: SizeConfig.sidepadding,
                                  child: Text(
                                    widget.argument.orderOrPurchases.purchaseDetails.paymentOption.title,
//                                    AppStrings.PREPAYMENT.tr(),
                                    style: AppStyles.BlackStyleWithBold700Font_14(context),
                                  ),
                                ),
                                SizeConfig.CVerticalSpacevMedium(),
                                Padding(
                                  padding: SizeConfig.sidepadding,
                                  child: CustomDividerWidget(
                                    height: 1,
                                  ),
                                ),
                                SizeConfig.CVerticalSpacevMedium(),
                                Padding(
                                  padding: SizeConfig.sidepadding,
                                  child: Text(
                                    AppStrings.ESTIMATION_AND_BUDGET.tr() + ':',
                                    style: AppStyles.BlackStyleWithBold700Font_14(context),
                                  ),
                                ),
                              ],
                            );
                          }
                          if (index > 0 &&
                              index < widget.argument.orderOrPurchases.purchaseDetails.products.length + 1) {
                            return CheckOutProductView(
                              product: widget.argument.orderOrPurchases.purchaseDetails.products[index - 1],
                            );
                          }

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizeConfig.CVerticalSpacevEMedium(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      StringService.getBudgetName(widget.argument.orderOrPurchases.purchaseDetails)
                                              .name +
                                          ':',
                                      style: AppStyles.BlackStyleWithBold800Font_20(context),
                                      textAlign: TextAlign.left,
                                    )),
                                    SizeConfig.horizontalSpaceLarge(),
                                    Text(
                                        '${AppStrings.euro + ' '}${NumberService.addAfterCommaTwoZeros(widget.argument.orderOrPurchases.purchaseDetails.totalAmount.toString(), context)}',
                                        style: AppStyles.BlackStyleWithBold800Font_20(context))
                                  ],
                                ),
                              ),
                              SizeConfig.CVerticalSpaceSmallMediumC12(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      AppStrings.COURIER_FEE.tr() + ":",
                                      style: AppStyles.BlackStyleWithBold800Font_20(context),
                                      textAlign: TextAlign.left,
                                    )),
                                    SizeConfig.horizontalSpaceLarge(),
                                    Text(
                                        '${AppStrings.euro + ' '}${NumberService.addAfterCommaTwoZeros(widget.argument.orderOrPurchases.candidates.first.charge.toString(), context)}',
                                        style: AppStyles.BlackStyleWithBold800Font_20(context))
                                  ],
                                ),
                              ),
                              SizeConfig.CVerticalSpaceSmallMediumC12(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: CustomDividerWidget(
                                  height: 1,
                                ),
                              ),
                              SizeConfig.CVerticalSpaceMedium(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: AutoSizeText(
                                      StringService.total(
                                              widget.argument.orderOrPurchases.purchaseDetails.paymentOption) +
                                          ":",
                                      maxLines: 1,
                                      minFontSize: 8,
                                      maxFontSize: AppStyles.BlackStyleFont_c16(context).fontSize,
                                      style: AppStyles.BlackStyleFont_c16(context),
                                      textAlign: TextAlign.left,
                                    )),
                                    SizeConfig.horizontalSpaceLarge(),
                                    Text('${AppStrings.euro + ' '}${NumberService.priceAfterConvert(90, context)}',
                                        style: AppStyles.BlackStyleWithBold800Font_24(context))
                                  ],
                                ),
                              ),
                              SizeConfig.CVerticalSpaceMedium(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: Text(
                                  AppStrings.COMMENT.tr() + ':',
                                  style: AppStyles.BlackStyleWithBold800Font_20(context),
                                ),
                              ),
                              SizeConfig.verticalSpaceSmall(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      "When you deliver, please do not ring the bell. My baby can sleep. Just"
                                      " call me and I'll meet you.",
                                      style: AppStyles.BlackStyleFont_16(context),
                                    )),
                                    SizeConfig.horizontalSpaceBig(),
                                  ],
                                ),
                              ),
                              SizeConfig.CVerticalSpacevMedium(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: CustomDividerWidget(
                                  height: 1,
                                ),
                              ),
                              SizeConfig.CVerticalSpacevMedium(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(AppStrings.POSTED.tr() + ":",
                                            style: AppStyles.BlackStyleWithBold800Font_20(context))),
                                    Text(
                                        '${DateService.getDateFormatWithYear(DateTime(2020, 5, 12).toIso8601String(), context)}, 13:40',
                                        style: AppStyles.BlackStyleWithBoldW700Font_15(context)),
                                  ],
                                ),
                              ),
                              SizeConfig.verticalSpaceSmall(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(AppStrings.ORDER_ID.tr() + ":",
                                            style: AppStyles.BlackStyleWithBold800Font_20(context))),
                                    Text('345678', style: AppStyles.BlackStyleWithBoldW700Font_15(context)),
                                  ],
                                ),
                              ),
                              SizeConfig.CVerticalSpacevEMedium(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: SizeConfig.screenWidth * .85,
                                    child: RichText(
                                      text: TextSpan(
                                        text: AppStrings.BY_CLICKING_PLACE_THE_ORDER.tr(),
                                        style: AppStyles.BlackStyleFont300_16(context),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: AppStrings.TERMS_AND_CONDITION.tr(),
                                            style: AppStyles.BlackUnderlineStyleFont_16(context).copyWith(height: 1.24),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight * .18,
                              )
                            ],
                          );
                        }, childCount: widget.argument.orderOrPurchases.purchaseDetails.products.length + 2),
                      ),
                    ),
                  ],
                ),
          floatingActionButtonAnimator: NoScalingAnimation(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.screenWidth * .1,
                right: SizeConfig.screenWidth * .1,
                bottom: SizeConfig.screenHeight * .04),
            child: ButtonWidget(
                radius: AppConstants.button_Radius,
                fontSize: AppConstants.fontSizeSmall,
                buttonColor: Theme.of(context).primaryColor,
                buttonText: AppStrings.SUBMIT_ORDER.tr(),
                onPressed: () {
                  model.onSubmit(widget.argument.orderOrPurchases, context);
                }),
          ),
        );
      },
    );
  }
}

class CheckOutPageArgument {
  OrderOrPurchases orderOrPurchases;

  CheckOutPageArgument({this.orderOrPurchases});
}
