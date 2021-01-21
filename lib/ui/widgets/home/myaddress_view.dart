import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/myaddress_viewmodel.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/bottomsheet_search_view.dart';
import 'package:storeangelApp/ui/shared/buttonWithIcon.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';

class MyAddressView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: SizeConfig.screenHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
            color: Theme.of(context).cardColor,
          ),
          child: Padding(
            padding:  SizeConfig.paddingMediumhighSide,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizeConfig.CVerticalSpacevMedium(),
                  Row(
                    children: [
                      Expanded(child: Text(AppStrings.MY_ADDRESSES.tr(),
                      style: AppStyles.BlackStyleWithBold800Font_24(context),)),
                      InkWell(child: Image.asset(AssetsPath.closeIcon,),
                      onTap: (){
                        Navigator.pop(context);
                      },)
                    ],
                  ),
                  SizeConfig.CVerticalSpacevMedium(),

                  BaseView<MyAddressViewModel>(
                    onModelReady: (model)=>model.getUserAddresses(''),
                    builder: (context,model,child){
                      if(model.state==ViewState.Busy){
                        return AppConstants.circulerProgressIndicator();

                      }else{
                        return ListView.builder(itemCount: model.myaddresses.length+1,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap:true,itemBuilder: (context,int index){

                          if(index==model.myaddresses.length){
                            return  ButtonWithIcon(
                              height: AppConstants.ContainerHeight_widthMedium,
                              buttonText: AppStrings.ADD_NEW_ADDRESS.tr(), onPressed: (){
                                TextEditingController controller=TextEditingController();
                              BottomSheetViewForSearch().onImageClick(context, controller, true,false);
                              controller.addListener(() {
                                if(controller.text!=''){
                                  print('##########3####${controller.text}');
                                }
                              });



                            },icon: Icons.add_circle,buttonColor: AppColors.primaryGradient,space: true,
                              iconColor: AppColors.green,
                              fontSize: SizeConfig.fontSizeLarge,
                              iconSize: SizeConfig.fontSizeLargest,
                              radius: AppConstants.button_Radius,textColor: AppColors.green,);
                          }
                          return Padding(
                            padding:  EdgeInsets.only(
                              bottom: AppConstants.margin15,
                              top: AppConstants.margin15
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.radio_button_checked,color: AppColors.green,),
                                SizeConfig.horizontalSpaceSmall(),
                                Expanded(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(model.myaddresses[index].name,
                                    style: AppStyles.BlackStyleFontWeightSmall_20(context),),
                                    SizeConfig.verticalSpaceSmall(),
                                    Text('${model.myaddresses[index].state},${model.myaddresses[index].country}',
                                    style: AppStyles.GrayStyleWithBold500_Font16(context),)

                                  ],
                                ),
                                ),
                              ],
                            ),
                          );
                        });
                      }
                    },

                  ),

                ],
              ),
            ),
          ),
        ),
        Positioned.fill(child: Padding(
          padding: SizeConfig.bottomsidePadding,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ButtonWidget(

                radius: AppConstants.button_Radius,
                fontSize:AppConstants.fontSizeSmall,

                buttonColor: Theme.of(context).primaryColor,
                buttonText: AppStrings.DONE.tr(),
                onPressed: (){
                  Navigator.pop(context);

                }),
          ),
        ))
      ],
    );
  }
  double getListHeight(int itemCount){
    if(itemCount>=5)return SizeConfig.screenHeight*.70;
    if(itemCount==4)return SizeConfig.screenHeight*.56;
    if(itemCount==3)return SizeConfig.screenHeight*.42;
    if(itemCount==2)return SizeConfig.screenHeight*.28;
    if(itemCount==1)return SizeConfig.screenHeight*.14;
    else return SizeConfig.screenHeight*0.2;
  }
}
