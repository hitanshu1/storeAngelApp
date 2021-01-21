import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/nearby_places_model.dart';
import 'package:storeangelApp/core/models/places_all_model.dart';
import 'package:storeangelApp/core/viewmodel/googleMapsFindAddress_viewModel.dart';
import 'package:storeangelApp/core/viewmodel/selectAddress_viewmodel.dart';

class NearByPlacesList extends StatelessWidget {
  final List<Place> places;
  final List<NearByPlace> nearByplaces;
  final TextEditingController controller;
  final GoogleMapsFindAddressModel model;
  final StateSetter updateState;
  final bool pickStoreScreen;
  final TextEditingController addressController;
  final double lat, lng;
  final Function onChange;

  NearByPlacesList(
      {this.nearByplaces,
      this.places,
      this.controller,
      this.model,
      this.updateState,
      this.pickStoreScreen,
      this.lat,
      this.lng,
      this.addressController,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: places.length,
      itemBuilder: (context, index) {
        return Consumer<SelectAddressViewModel>(
          builder: (context, model, child) => GestureDetector(
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  AppConstants.TextField_Contentpading_top, AppConstants.TextField_Contentpading_top, 0, 0),
              child: Column(
                children: <Widget>[
                  Divider(
                    color: AppColors.darkGrayColor,
                  ),
                  SizeConfig.VerticalSpaceSmallMedium(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                          flex: 1,
                          child: Icon(
                            Icons.location_on,
                            color: AppColors.darkGrayColor,
                            size: AppConstants.imageHeight_width,
                          )),
                      Container(
                        padding: EdgeInsets.all(AppConstants.marginVerySmall1),
                      ),
                      Flexible(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              places[index].name.tr(),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: AppStyles.BlackStyleFont_20(context),
                            ),
                            SizeConfig.verticalSpaceSmall(),
                            Text(
                              places[index].address.tr(),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: AppStyles.darkGrayLittleStyle_Font10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () {
              updateState(() {
                model.getLatLongFromAddress(places[index].address);
                model.popToScreen();
                if (pickStoreScreen == true) {
                  controller.text = places[index].name;
                }
                if (addressController != null) {
                  addressController.text = places[index].address;
                }
                if (onChange != null) {
                  if(places?.isNotEmpty??false) onChange(places[index]);
                  else onChange(null);
                }
              });
            },
          ),
        );
      },
    );
  }
}
