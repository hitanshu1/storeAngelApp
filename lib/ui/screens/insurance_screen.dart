import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/insurance_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/shared/custom_divider_widget.dart';
import 'package:storeangelApp/ui/shared/platform_alert_dialog.dart';
import 'package:storeangelApp/ui/shared/rectangler_imagepicker_button.dart';
import 'package:storeangelApp/ui/widgets/signup/first_lastname_widget.dart';

class InsuranceScreen extends StatelessWidget {
  static const String routeName = 'notification';

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Gray,context);
    final profileModel=Provider.of<ProfileViewModel>(context);
    return CustomScaffold(
      appBar: CustomAppBar(
        leading: BackButton(
          color: Theme.of(context).iconTheme.color,
          onPressed: (){
            profileModel.changeView(ProfilePageView.home);
          },
        ),
        title: Text(AppStrings.INSURANCE.tr(),
          style: AppStyles.BlackStyleWithBold800Font_24(context),
          textAlign: TextAlign.center,),
      ),
      body: BaseView<InsuranceViewModel>(
        builder: (context,model,child){
          if(model.state==ViewState.Busy){
            return AppConstants.circulerProgressIndicator();
          }else{
            return ListView(
              children: [
                SizeConfig.verticalSpace(SizeConfig.bottomPadding.bottom/2),
                Padding(
                  padding:SizeConfig.sidepadding,
                  child: Row(
                    children: [
                      Expanded(child: Text(AppStrings.I_HAVE_INSURANCE_FOR_DAMAGES.tr(),
                          style: AppStyles.BlackStyleFontW600_12(context))),
                      CupertinoSwitch(value: model.insuranceValue, onChanged: (value){

                        model.onChangeInsuranceValue(value);

                      })

                    ],
                  ),
                ),
                Padding(
                  padding: SizeConfig.sidepadding,
                  child: CustomDividerWidget(),
                ),


                SizeConfig.CVerticalSpaceSmallMedium(),
               Opacity(
                 opacity: model.insuranceValue?1:.4,
                 child: Padding(
                   padding: SizeConfig.sidepadding,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         AppStrings.INSURANCE_NAME.tr(),
                         style: AppStyles.GrayStyle_Font16(context),
                         textAlign: TextAlign.start,
                        ),
                       SizeConfig.verticalSpaceSmall(),
                       TextTextfieldWidget(
                         enabled: model.insuranceValue,
                         hint: '',
                         radius: SizeConfig.introGetStarted_button_Radius,
                         buttonColor: Colors.white,
                         controller: model.insuranceNameController,
                       ),
                       SizeConfig.CVerticalSpaceMedium(),
                       Text(
                         AppStrings.INSURANCE_VALUE.tr(),
                         style: AppStyles.GrayStyle_Font16(context),
                         textAlign: TextAlign.start,
                       ),
                       SizeConfig.verticalSpaceSmall(),
                       SizedBox(
                         width: SizeConfig.screenWidth*.5,
                         child: TextTextfieldWidget(
                           enabled: model.insuranceValue,
                           hint: '',
                           radius: SizeConfig.introGetStarted_button_Radius,
                           buttonColor: Colors.white,
                          controller: model.isuranceValueController,
                           inputFormatters: <TextInputFormatter>[
                             FilteringTextInputFormatter.digitsOnly

                           ],
                         suffixWidget: Padding(
                           padding: SizeConfig.sidepadding,
                           child: Text('${AppStrings.euro+' '}',style: AppStyles.BlackStyleW500FontC16(context),),
                         ),
                         ),
                       ),
                       SizeConfig.CVerticalSpaceBig(),
                       model.imageFile!=null?Stack(
                         children: [
                           Container(
                             height: AppConstants.ContsinerHeight_WidthC140,
                             width: SizeConfig.screenWidth,
                             decoration: BoxDecoration(
                               image: DecorationImage(image: FileImage(model.imageFile),fit: BoxFit.cover,
                               ),
                               borderRadius: BorderRadius.circular(20)
                             ),
                           ),
                           Positioned.fill(child: Align(
                             alignment: Alignment.center,
                             child: Container(
                               decoration: BoxDecoration(
                                 color: AppColors.black.withOpacity(.4),
                                   borderRadius: BorderRadius.circular(20)
                               ),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   SizedBox(
                                     height: 40,
                                       child: Image.asset(AssetsPath.roundWhitSelected)),
                                   SizeConfig.CVerticalSpaceMedium(),
                                   Text(AppStrings.REMOVE.tr(),style: AppStyles.WhiteStyle_Font20,)
                                 ],
                               ),
                             ),
                           ))
                         ],
                       ):RectangularImagePickerButton(
                         onTap: (){
                           _optionsDialogBox(model, context);
                         },
                         height: AppConstants.ContsinerHeight_WidthC140,
                         width: SizeConfig.screenWidth,
                         title: AppStrings.UPLOAD_INSURANCE_FILES.tr(),
                         color: AppColors.lightGreyColor,
                         radius: 20,
                       ),
                     ],
                   ),
                 ),
               ),

                SizeConfig.verticalSpaceSmall(),

              ],
            );
          }
        },
      ),
    );
  }
  void _optionsDialogBox(InsuranceViewModel model, BuildContext context) async {
    PlatformAlertDialog(
      title: AppStrings.GET_YOUR_IMAGE.tr(),
      content: '\n${AppStrings.SELECT_WHICH_IMAGE_OPTION_YOU_WANT_TO_CHOOSE.tr()}\n',
      defaultActionText: AppStrings.OPEN_CAMERA_DIALOG_TEXT.tr(),
      defaultFunction: model.openCamera,
      defaultActionText2: AppStrings.OPEN_GALLERY_DIALOG_TEXT.tr(),
      defaultFunction2: model.openGallery,
    ).show(context);
  }
}
