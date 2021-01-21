import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/viewmodel/googleMapsFindAddress_viewModel.dart';
import 'package:storeangelApp/ui/widgets/home/places_list_item_widget.dart';

class BottomSheetViewForSearch {
  List<StoreDataModel> selectedStoreList = <StoreDataModel>[];
  bool _visibleClose = true;

  final _locationSearchController = TextEditingController();
  final FocusNode _locationSearchFocusNode = FocusNode();

  void onImageClick(
      BuildContext context, TextEditingController searchAddressTopController, bool isPickStoreScreen, bool country,
      [double lat, double lng, TextEditingController addressController, Function onChange]) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.introGetStarted_button_Radius),
        ),
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Container(
                height: SizeConfig.screenHeight * 0.9,
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(AppConstants.backArrowContainreRightRadius),
                    topRight: const Radius.circular(AppConstants.backArrowContainreRightRadius),
                  ),
                ),
                child: Container(
                  child: Consumer<GoogleMapsFindAddressModel>(
                    builder: (context, model, child) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.05,
                            right: SizeConfig.screenWidth * 0.05,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppStrings.FIND_YOUR_ADDRESS.tr(),
                                style: AppStyles.BlackStyleFont_20(context),
                              ),
                              TextButton(
                                onPressed: () {
                                  model.navigatorPop();
                                },
                                child: Text(
                                  AppStrings.CANCEL_BUTTON.tr(),
                                  style: AppStyles.GreenStyle_Font20(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizeConfig.verticalSpaceMedium(),
                        Row(
                          children: <Widget>[
                            Container(
                                height: SizeConfig.screenHeight * 0.07,
                                width: SizeConfig.screenWidth * 0.90,
                                margin: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.05,
                                  right: SizeConfig.screenWidth * 0.05,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(SizeConfig.introGetStarted_button_Radius),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(AppConstants.ShadowBox_WithOpacity),
                                      spreadRadius: AppConstants.ShadowBox_SpreadRadius,
                                      blurRadius: AppConstants.ShadowBox_BlurRadius,
                                      offset: Offset(0, AppConstants.ShadowBox_Offset), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 5,
                                      child: Center(
                                        child: TextField(
                                          autofocus: true,
                                          style: AppStyles.BlackStyle_Font12(context),
                                          controller: _locationSearchController,
                                          focusNode: _locationSearchFocusNode,
                                          textInputAction: TextInputAction.next,
                                          maxLines: 1,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.fromLTRB(
                                                  AppConstants.TextField_Contentpading_top, 0.0, 0.0, 0.0),
                                              hintText: AppStrings.SEARCH.tr()),
                                          onChanged: (value) {
                                            setState(() {
                                              model.getAllPlaces(value, country);
                                            });
                                          },
                                        ),
                                        //  ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Visibility(
                                        child: InkWell(
                                          onTap: () {
                                            _locationSearchController.text = '';
                                          },
                                          child: Image.asset(
                                            AssetsPath.closeIcon,
                                            height: SizeConfig.iconSize,
                                            width: SizeConfig.iconSize,
                                          ),
                                        ),
                                        visible: _visibleClose,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        Container(
                          height: SizeConfig.screenHeight * 0.69,
                          child: NearByPlacesList(
                            places: model.places,
                            controller: searchAddressTopController,
                            addressController: addressController,
                            model: model,
                            lat: lat,
                            lng: lng,
                            updateState: setState,
                            pickStoreScreen: isPickStoreScreen,
                            onChange: onChange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          });
        });
  }
}
