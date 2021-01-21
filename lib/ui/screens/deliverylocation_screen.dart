import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/address.dart';
import 'package:storeangelApp/core/models/payment_option.dart';
import 'package:storeangelApp/core/models/places_all_model.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/deliverylocation_viewmodel.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/bottomsheet_search_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customSliverAppBar.dart';
import 'package:storeangelApp/ui/shared/showbottomSheet.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/deliverylocation/delevery_location_checkbox.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/deliverylocation/singleline_selectable_option.dart';
import 'package:storeangelApp/ui/widgets/order_courier_flow/order_courier_flow.dart';
import 'package:storeangelApp/ui/widgets/share/custom_date_picker.dart';

class DeliveryLocationScreen extends StatefulWidget {
  static const String routeName = 'deliveryLocationScreen';
  final PurchaseDetails purchaseDetails;

  DeliveryLocationScreen({this.purchaseDetails});

  @override
  _DeliveryLocationScreenState createState() => _DeliveryLocationScreenState();
}

class _DeliveryLocationScreenState extends State<DeliveryLocationScreen> {
  var _radius = SizeConfig.radiusOfSliverAppbar;
  ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FocusNode _commentNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_isAppBarExpanded) {
        setState(() {
          _radius = 0.0;
        });
      } else {
        setState(() {
          _radius = SizeConfig.radiusOfSliverAppbar;
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
    _commentNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(milliseconds: 300), () => StatusBarService.changeStatusBarColor(StatusBarType.Light, context));
    return BaseView<DeliveryLocationViewModel>(
      onModelReady: (deliveryLocationViewModel) {
        deliveryLocationViewModel.getAddress(UserModel(), widget.purchaseDetails);
        deliveryLocationViewModel.init(_commentNode);
      },
      builder: (context, deliveryLocationViewModel, child) {
        return Scaffold(
          key: _scaffoldKey,
          body: deliveryLocationViewModel.state == ViewState.Busy
              ? AppConstants.circulerProgressIndicator()
              : CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    CustomSliverAppBar(
                        backgroundColor: Theme.of(context).cardColor,
                        pinned: true,
                        floating: false,
                        leading: BackButton(
                          color: Theme.of(context).iconTheme.color,
                          onPressed: () {
                            deliveryLocationViewModel.navigatorPop();
                          },
                        ),
                        title: Text(
                          '${AppStrings.TERMS_AND_CONDITIONS.tr()}',
                          style: AppStyles.BlackStyleWithBold800Font_24(context),
                        ),
                        centerTitle: true,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(_radius), bottomRight: Radius.circular(_radius))),
                        bottom: PreferredSize(
                          child: OrderCourierStatusWidget(
                            status: OrderCourierStatus.Location,
                          ),
                          preferredSize: Size.fromHeight(SizeConfig.expandedHeight * .5),
                        )),
                    SliverPadding(
                      padding: EdgeInsets.only(top: 20),
                      sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((context, int index) {
                        if (index == 0) {
                          return Padding(
                            padding: SizeConfig.sidepadding,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    AppStrings.YOUR_DELIVERY_LOCATION.tr() + ':',
                                    textAlign: TextAlign.left,
                                    style: AppStyles.BlackStyleWithBold800Font_20(context),
                                  ),
                                ),
                                InkWell(
                                  child: AppConstants.addIcon,
                                  onTap: () {
                                    TextEditingController controller = TextEditingController();
                                    TextEditingController addressController = TextEditingController();
                                    BottomSheetViewForSearch().onImageClick(
                                        context, controller, true, false, 0.0, 0.0, addressController, (Place val) {
                                      if (val != null) {
                                        deliveryLocationViewModel.addAddress(AddressModel(
                                          name: val.name,
                                        ));
                                      }
                                    });
                                  },
                                )
                              ],
                            ),
                          );
                        }
                        if (index == deliveryLocationViewModel.addresses.length + 1) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizeConfig.CVerticalSpacevMedium(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: Text(
                                  AppStrings.DELIVERY_TYPE.tr() + ':',
                                  textAlign: TextAlign.left,
                                  style: AppStyles.BlackStyleWithBold800Font_20(context),
                                ),
                              ),
                              SizeConfig.CVerticalSpaceSmallMediumC11(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: SingleLineSelectableOption(
                                  title: AppStrings.LEAVE_AT_DESTINATION.tr(),
                                  value: deliveryLocationViewModel.leaveAtDestination,
                                  onTap: () {
                                    deliveryLocationViewModel.updateDestinationType();
                                  },
                                ),
                              ),
                              SizeConfig.CVerticalSpacevMedium(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: Text(
                                  AppStrings.ORDER_PAYMENT.tr() + ':',
                                  textAlign: TextAlign.left,
                                  style: AppStyles.BlackStyleWithBold800Font_20(context),
                                ),
                              ),
                              SizeConfig.CVerticalSpaceSmallMediumC11(),
                              Column(
                                children: [
                                  Padding(
                                    padding: SizeConfig.sidepadding,
                                    child: SingleLineSelectableOption(
                                      title: deliveryLocationViewModel.paymentOptions[0].title,
                                      value: deliveryLocationViewModel.selectedOption.paymentOptionEnum ==
                                          deliveryLocationViewModel.paymentOptions[0].paymentOptionEnum,
                                      onTap: () {
                                        deliveryLocationViewModel
                                            .onSelectPayOption(deliveryLocationViewModel.paymentOptions[0]);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: SizeConfig.sidepadding.copyWith(top: 4),
                                    child: SingleLineSelectableOption(
                                      title: deliveryLocationViewModel.paymentOptions[1].title,
                                      value: deliveryLocationViewModel.selectedOption.paymentOptionEnum ==
                                              deliveryLocationViewModel.paymentOptions[1].paymentOptionEnum ||
                                          deliveryLocationViewModel.selectedOption.paymentOptionEnum ==
                                              deliveryLocationViewModel.paymentOptions[2].paymentOptionEnum,
                                      onTap: () {
                                        deliveryLocationViewModel
                                            .onSelectPayOption(deliveryLocationViewModel.paymentOptions[1]);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: SizeConfig.sidepadding.copyWith(top: 4),
                                    child: Builder(builder: (context) {
                                      bool isTextColorActive =
                                          deliveryLocationViewModel.selectedOption.paymentOptionEnum ==
                                              deliveryLocationViewModel.paymentOptions[1].paymentOptionEnum;
                                      bool isDarkMode =
                                          Provider.of<AppThemeViewModel>(context).themeData == AppTheme.dark;

                                      return SingleLineSelectableOption(
                                        title: deliveryLocationViewModel.paymentOptions[2].title,
                                        value: deliveryLocationViewModel.selectedOption.paymentOptionEnum ==
                                            deliveryLocationViewModel.paymentOptions[2].paymentOptionEnum,
                                        textColor: isTextColorActive
                                            ? null
                                            : isDarkMode
                                                ? Colors.white60
                                                : Colors.black54,
                                        onTap: () {
                                          if (deliveryLocationViewModel.selectedOption.paymentOptionEnum !=
                                              PaymentOptionEnum.withBudgetConstraint) {
                                            deliveryLocationViewModel
                                                .onSelectPayOption(deliveryLocationViewModel.paymentOptions[2]);
                                          } else {
                                            deliveryLocationViewModel
                                                .onSelectPayOption(deliveryLocationViewModel.paymentOptions[1]);
                                          }
                                          deliveryLocationViewModel.changePaymentRestriction();
                                        },
                                      );
                                    }),
                                  ),
                                ],
                              ),
                              SizeConfig.CVerticalSpacevMedium(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: Text(
                                  AppStrings.DELIVERY_DATE.tr() + ':',
                                  textAlign: TextAlign.left,
                                  style: AppStyles.BlackStyleWithBold800Font_20(context),
                                ),
                              ),
                              SizeConfig.CVerticalSpaceSmallMediumC11(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: SingleLineSelectableOption(
                                  title: AppStrings.AS_SOON_AS_POSSIBLE.tr(),
                                  value: deliveryLocationViewModel.deliveryTimeSelectValue == 1,
                                  onTap: () {
                                    deliveryLocationViewModel.onSelectDeliveryTimeOption(1);
                                  },
                                ),
                              ),
                              SizeConfig.verticalSpaceSmall(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: SingleLineSelectableOption(
                                  title: AppStrings.TOMORROW_DELIVERY.tr(),
                                  value: deliveryLocationViewModel.deliveryTimeSelectValue == 2,
                                  onTap: () {
                                    deliveryLocationViewModel.onSelectDeliveryTimeOption(2);
                                  },
                                ),
                              ),
                              SizeConfig.verticalSpaceSmall(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: SingleLineSelectableOption(
                                  title: deliveryLocationViewModel.selectDateAndTime != null
                                      ? deliveryLocationViewModel.selectDateAndTime
                                      : AppStrings.SELECT_DELIVERY_DATE.tr(),
                                  value: deliveryLocationViewModel.deliveryTimeSelectValue == 3,
                                  onTap: () => onTapSelectDate(deliveryLocationViewModel, context),
                                ),
                              ),
                              SizeConfig.CVerticalSpacevMedium(),
                              Padding(
                                padding: SizeConfig.sidepadding,
                                child: Text(
                                  AppStrings.COMMENT.tr() + ':',
                                  textAlign: TextAlign.left,
                                  style: AppStyles.BlackStyleWithBold800Font_20(context),
                                ),
                              ),
                              Padding(
                                padding: SizeConfig.padding,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(AppConstants.button_Radius)),
                                  child: Padding(
                                    padding: SizeConfig.padding,
                                    child: TextField(
                                      focusNode: _commentNode,
                                      minLines: 4,
                                      maxLines: 4,
                                      textInputAction: TextInputAction.done,
                                      style: AppStyles.BlackStyleFont_20(context),
                                      onTap: () {
                                        Future.delayed(Duration(milliseconds: 300),
                                            () => StatusBarService.changeStatusBarColor(StatusBarType.Light, context));
                                      },
                                      onSubmitted: (txt) {
                                        Future.delayed(Duration(milliseconds: 500),
                                            () => StatusBarService.changeStatusBarColor(StatusBarType.Light, context));
                                      },
                                      decoration: InputDecoration.collapsed(
                                          hintText: '', hintStyle: AppStyles.GrayStyle_Font16(context)),
                                    ),
                                  ),
                                ),
                              ),
                              SizeConfig.CVerticalSpacevMedium(),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.padding.left,
                                    right: SizeConfig.padding.right,
                                    bottom: SizeConfig.screenHeight * .04),
                                child: ButtonWidget(
                                    radius: AppConstants.button_Radius,
                                    fontSize: AppConstants.fontSizeSmall,
                                    buttonColor: Theme.of(context).primaryColor,
                                    buttonText: AppStrings.NEXT.tr(),
                                    onPressed: () {
                                      deliveryLocationViewModel.onPublishOrder(_scaffoldKey);
                                    }),
                              )
                            ],
                          );
                        }

                        return Padding(
                          padding: SizeConfig.sidepadding,
                          child: Padding(
                            padding: SizeConfig.smallerVerticalPadding3,
                            child: InkWell(
                              child: Container(
                                child: Padding(
                                  padding: SizeConfig.padding,
                                  child: Row(
                                    children: [
                                      DeliveryLocationCheckBoxWidget(
                                          value: deliveryLocationViewModel.selectedAddress ==
                                              deliveryLocationViewModel.addresses[index - 1]),
                                      SizeConfig.horizontalSpaceSmall(),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              deliveryLocationViewModel.addresses[index - 1].name,
                                              style: deliveryLocationViewModel.selectedAddress ==
                                                      deliveryLocationViewModel.addresses[index - 1]
                                                  ? AppStyles.WhiteStyleWithBold800_Font16
                                                  : AppStyles.BlackStyleWithBold800Font_16(context),
                                            ),
                                            SizeConfig.CVerticalSpaceVarySmall(),
                                            Text(
                                              deliveryLocationViewModel.addresses[index - 1].address,
                                              style: deliveryLocationViewModel.selectedAddress ==
                                                      deliveryLocationViewModel.addresses[index - 1]
                                                  ? AppStyles.WhiteStyle_Font16
                                                  : AppStyles.BlackStyleFont_16(context),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: deliveryLocationViewModel.selectedAddress ==
                                            deliveryLocationViewModel.addresses[index - 1]
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.circular(SizeConfig.radiusSmall)),
                              ),
                              onTap: () {
                                deliveryLocationViewModel
                                    .onSelectAddress(deliveryLocationViewModel.addresses[index - 1]);
                              },
                            ),
                          ),
                        );
                      }, childCount: deliveryLocationViewModel.addresses.length + 2)),
                    ),
                  ],
                ),
        );
      },
    );
  }

  void onTapSelectDate(DeliveryLocationViewModel deliveryLocationViewModel, BuildContext context) {
    DateTime now = DateTime.now();
    int minuteDifference = now.minute != 0 ? 60 - now.minute : 0;
    DateTime initialDate = now.add(Duration(hours: 2, minutes: minuteDifference));
    ShowBottomSheet.showLarge(
        child: CustomDatePickerWidget(
          minuteInterval: 1,
          initialDatetime: initialDate,
          bottomText: AppStrings.NEXT_SELECT_END_TIME.tr(),
          onSelect: (dateTime) {
            deliveryLocationViewModel.onSelectStartDate(dateTime);
            if (dateTime != null) {
              Navigator.pop(context);
              ShowBottomSheet.showLarge(
                  child: CustomDatePickerWidget(
                    minuteInterval: 1,
                    initialDatetime: deliveryLocationViewModel.startDate.add(Duration(hours: 2)),
                    bottomText: AppStrings.DELIVERY_UNTIL.tr(),
                    minimumDate: deliveryLocationViewModel.startDate.add(Duration(hours: 2)),
                    onSelect: (dateTime) {
                      if (dateTime != null) {
                        deliveryLocationViewModel.onSelectEndDate(dateTime);
                        deliveryLocationViewModel.onSelectDeliveryTimeOption(3);
                        deliveryLocationViewModel.navigatorPop();
                      } else {
                        deliveryLocationViewModel.navigatorPop();
                      }
                    },
                  ),
                  context: context,
                  heightFactor: .4);
            }
          },
        ),
        context: context,
        heightFactor: .4);
  }
}
