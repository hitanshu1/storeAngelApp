import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/myaddress_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/bottomsheet_search_view.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/widgets/profile/view_address.dart';
class MyAddresses extends StatefulWidget {
  @override
  _MyAddressesState createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Gray,context);
    final profileModel=Provider.of<ProfileViewModel>(context);
    return BaseView<MyAddressViewModel>(
      onModelReady: (model)=>model.initialize(_scrollController),
      builder:(context, myAddressViewModel, child)=> Scaffold(
        appBar: CustomAppBar(
          elevation: myAddressViewModel.hasShadow?4:0,
          leading: BackButton(
            color: Theme.of(context).iconTheme.color,
            onPressed: (){
              profileModel.changeView(ProfilePageView.home);
            },
          ),
          title: Text(AppStrings.MY_ADDRESSES.tr(),
            style: AppStyles.BlackStyleWithBold800Font_24(context),
            textAlign: TextAlign.center,),
          actions: [
            IconButton(icon:  AppConstants.addIcon,
                onPressed: (){
                  BottomSheetViewForSearch().onImageClick(context, null, false,false);
                }),
          ],
        ),
        body: Builder(
          builder: (context){
            if(myAddressViewModel.state==ViewState.Busy){
              return AppConstants.circulerProgressIndicator();
            }else{
              return ListView.builder(
                padding: EdgeInsets.only(top: SizeConfig.bottomPadding.bottom*.5),
                  controller: _scrollController,
                  itemCount: myAddressViewModel.myaddresses.length,itemBuilder: (context,int index){
                return ViewAddress(address: myAddressViewModel.myaddresses[index],);
              });
            }
          },
        ),
      ),
    );
  }
}
