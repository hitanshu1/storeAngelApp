import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/viewmodel/pickStore_viewmodel.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/widgets/pick_store/pick_store_header_widget.dart';
import 'package:storeangelApp/ui/widgets/pick_store/picker_store_list_widget.dart';
import '../../../getIt.dart';

class PickStoreScreen extends StatefulWidget {
  static const String routeName = 'pickStore';
  final PickStoreScreenArguments arguments;

  PickStoreScreen({this.arguments});

  @override
  _PickStoreScreenState createState() => _PickStoreScreenState();
}

class _PickStoreScreenState extends State<PickStoreScreen> {
  List<StoreDataModel> selectedStoreList = <StoreDataModel>[];

  final _locationSearchController = TextEditingController();
  final _searchAddressTopController = TextEditingController(text: AppStrings.NUMBRECH_12.tr());
  final _searchNearbyStoreController = TextEditingController();
  final _searchController = TextEditingController();

  final FocusNode _searchNearbyStoreFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.arguments?.address != null) {
      _searchAddressTopController.text = widget.arguments.address;
    }
  }

  @override
  void dispose() {
    _locationSearchController.dispose();
    _searchAddressTopController.dispose();
    _searchNearbyStoreController.dispose();
    _searchController.dispose();
    _searchNearbyStoreFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.sizeConfigInit(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getIt<PickStoreViewModel>()),
      ],
      child: BaseView<PickStoreViewModel>(
        onModelReady: (model) {
//          model.getStoreData();
          model.textFieldNode = _searchNearbyStoreFocusNode;
          },
        builder: (context, pickStoreModel, child) => CustomScaffold(
          resizeToAvoidBottomInset: false,
        body:Stack(
          children: [
            CustomScrollView(
              slivers: [
                PickStoreHeader(
                ),
                SizeConfig.verticalSliverSmallSpace(),
                PickerStoreListWidget(),



              ],
            ),
            Positioned.fill(child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:  SizeConfig.sidepadding.copyWith(
                  bottom: SizeConfig.screenHeight * 0.03
                ),
                child: ButtonWidget(
                  buttonText: AppStrings.DONE.tr(),
                  buttonColor: Theme.of(context).primaryColor,
                  gradient: pickStoreModel.selectedStoreList.length > 0?AppColors.primaryGradient:AppColors.blackGradient ,
                  fontSize: SizeConfig.fontSizeMedium,
                  radius: SizeConfig.borderRadius,
                  textColor: Colors.white,
                  onPressed: () {
                    if(pickStoreModel.selectedStoreList.length > 0){
                      pickStoreModel.updateList();
                      if (widget.arguments?.isMyStoreScreen ?? false) {
                        pickStoreModel.popToScreen();
                      } else {
                        pickStoreModel.navigateToScreen();
                      }
                    }

                  },
                ),
              ),
            ))
          ],
        ),
        ),
      ),
    );
  }
}

class PickStoreScreenArguments {
  String address;
  bool isMyStoreScreen;

  PickStoreScreenArguments({this.address: "", this.isMyStoreScreen: false});
}
