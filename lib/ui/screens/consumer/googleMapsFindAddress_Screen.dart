
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/viewmodel/selectAddress_viewmodel.dart';
import 'package:storeangelApp/ui/screens/consumer/pick_Store_Screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/bottomsheet_search_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/button_widget_customheight.dart';
import 'package:storeangelApp/ui/shared/circuler_button_widget.dart';


class GoogleMapsFindAddressScreen extends StatefulWidget {
  static const String routeName = 'googleMapsFindAddressScreen';

  @override
  _GoogleMapsFindAddressScreenState createState() => _GoogleMapsFindAddressScreenState();
}

class _GoogleMapsFindAddressScreenState extends State<GoogleMapsFindAddressScreen> {
  List<Marker> allMarker = <Marker>[];

  final _locationSearchController = TextEditingController();

  final _searchController = TextEditingController();

  FocusNode _locationSearchFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _locationSearchController.dispose();
    _locationSearchFocusNode.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BaseView<SelectAddressViewModel>(
      onModelReady: (model)=>model.createMarker('1'),
      builder: (context, model, child) {
        if(model.state==ViewState.Busy){
          return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: AppConstants.circulerProgressIndicator());
        }
        return Scaffold(
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Stack(
              children: <Widget>[
                GoogleMap(
                  myLocationEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(model.currentLatitude, model.currentLongitude),
                    zoom: 16.0,
                  ),
                  markers: Set.from(model.allMarker),

                  circles:  Set.from(model.circles),
                  onMapCreated: (GoogleMapController controller) {
                    setState(() {
                      model.mapController = controller;
                    });

                    model.mapController.setMapStyle(model.mapStyle);


                  },

                ),
                Positioned(
                  top: SizeConfig.screenHeight * 0.09,
                  left: SizeConfig.screenWidth * 0.06,
                  right: SizeConfig.screenWidth * 0.06,
                  child: Column(
                    children: <Widget>[
                      Text(
                        AppStrings.ARE_YOU_HERE.tr(),
                        style: TextStyle(fontSize: SizeConfig.fontSizeLarger, color: Theme.of(context).focusColor, fontWeight: FontWeight.w700),
                      ),
                      SizeConfig.verticalSpaceMedium(),
                      Container(
                        margin:
                        EdgeInsets.only(left: SizeConfig.screenWidth * .09, right: SizeConfig.screenWidth * .09),
                        child: ButtonWidgetCustomHeight(
                          height: SizeConfig.buttonHeight,
                          name: AppStrings.CHANGE_DELIVERY_ADDRESS.tr(),
                          radius: SizeConfig.borderRadius*2,
                          colorButton: Theme.of(context).cardColor,
                          fontSize: SizeConfig.fontSizeMedium,
                          textColor: AppColors.primaryColor,
                          onPressed: () {
                            double lat,lng;
                            TextEditingController addressController=TextEditingController();
                            BottomSheetViewForSearch().onImageClick(context, null, false,false,lat,lng,addressController);
                            addressController.addListener(() async{
                              if(addressController.text.isNotEmpty){
                               model.onChangeMarker(addressController.text);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: SizeConfig.screenHeight * 0.06,
                  left: SizeConfig.screenWidth * 0.06,
                  right: SizeConfig.screenWidth * 0.06,
                  child: CircularButtonWidget(
                    buttonText: AppStrings.I_AM_HERE.tr(),
                    radius: SizeConfig.borderRadius,
                    buttonColor: Theme.of(context).primaryColor,
                    fontSize: SizeConfig.fontSizeMedium,
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      model.navigateToScreen(PickStoreScreen.routeName, model.currentAddress);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
    },
    );
  }
}
