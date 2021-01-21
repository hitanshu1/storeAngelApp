import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/available_status.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:timeago/timeago.dart' as timeago;




class AvailableWidget extends StatelessWidget {
  final AvailableStatus availableStatus;
  final Product product;
  AvailableWidget({this.availableStatus,this.product});


  Widget iconWidget(){
    if(availableStatus==AvailableStatus.few){
      return ViewAppImage(
        assetUrl: AssetsPath.pointer,
        height: 55,
        width: 55,
        radius: 55,
      );
    }else if(availableStatus==AvailableStatus.plenty){
      return ViewAppImage(
        assetUrl: AssetsPath.plenty,
        height: 55,
        width: 55,
        radius: 55,
      );

    }else if(availableStatus==AvailableStatus.runOut){
      return ViewAppImage(
        assetUrl: AssetsPath.runout,
        height: 55,
        width: 55,
        radius: 55,
      );

    }else{
      return ViewAppImage(
        assetUrl: AssetsPath.pointer,
        height: 55,
        width: 55,
        radius: 55,
      );
    }
  }

  String title(){
    if(availableStatus==AvailableStatus.few){
      return AppStrings.FEW_FULL_TEXT.tr();
    }else if(availableStatus==AvailableStatus.plenty){
      return AppStrings.PLENTY_FULL_TEXT.tr();
    }else if(availableStatus==AvailableStatus.runOut){
      return AppStrings.RUN_OUT_FULL_TEXT.tr();
    }else{
      return AppStrings.FEW.tr();
    }
  }
   Color get activeColor{
     if(availableStatus==AvailableStatus.few){
       return AppColors.amber;
     }else if(availableStatus==AvailableStatus.plenty){
       return AppColors.green;
     }else if(availableStatus==AvailableStatus.runOut){
       return AppColors.red;
     }else{
       return AppColors.amber;
     }

   }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 120,

          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              Container(
                height: availableStatus==AvailableStatus.few?60:120,
                width: 4,
                decoration: BoxDecoration(
                    color: activeColor,
                    borderRadius: BorderRadius.circular(10)
                ),

              ),
            ],
          ),
        ),
        SizeConfig.horizontalSpaceMedium(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [

                  ///image will change
                  ViewAppImage(
                    imageUrl: product.createdBy.imageUrl,
                    height: 40,
                    width: 40,
                    radius: 40,
                  ),
                  SizeConfig.horizontalSpaceSmall(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizeConfig.verticalSpaceSmall(),
                        Text(product.createdBy.name,style: AppStyles.BlackStyleWithBold800Font_20(context),
                          textAlign: TextAlign.center,),
                        SizeConfig.verticalSpaceSmall(),
                        Text(AppStrings.UPDATED.tr(),style:AppStyles.GrayStyle_Font16(context),
                          textAlign: TextAlign.left,)
                      ],
                    ),
                  ),
                ],
              ),
              SizeConfig.verticalSpaceSmall(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 40,
                      child: iconWidget()),
                  SizeConfig.horizontalSpaceSmall(),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title(),style: AppStyles.BlackStyleWithBold800Font_20(context),),


                      Text(timeago.format(DateTime.now().subtract(new Duration(hours: 2),),
                        locale: context.locale.toString()
                      ),style: AppStyles.GrayStyle_Font16(context),),
                      SizeConfig.verticalSpaceSmall(),
                    ],
                  )),

                ],
              ),
            ],
          ),
        )
      ],
    );

  }
}
