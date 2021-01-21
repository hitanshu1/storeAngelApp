import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/available_status.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class ViewProduct extends StatefulWidget {
  final Product product;

  final List<Product>selectedProducts;
 final Function onIncrement,onDecrement;
  ViewProduct({this.product,this.onIncrement,this.onDecrement,this.selectedProducts});

  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  Color get activeColor{
    if(widget.product.availableStatus==AvailableStatus.few){
      return AppColors.amber;
    }else if(widget.product.availableStatus==AvailableStatus.plenty){
      return AppColors.green;
    }else if(widget.product.availableStatus==AvailableStatus.runOut){
      return AppColors.red;
    }else{
      return AppColors.amber;
    }

  }

  String get title{
    if(widget.product.availableStatus==AvailableStatus.few){
      return 'Few';
    }else if(widget.product.availableStatus==AvailableStatus.plenty){
      return 'Plenty';
    }else if(widget.product.availableStatus==AvailableStatus.runOut){
      return 'Run Out';
    }else{
      return 'Few';
    }

  }
  int total=0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConfig.paddingHeighy01,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppConstants.RadiusMedium),
        ),
        child: Padding(
          padding:  SizeConfig.innerpadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ViewAppImage(
                height: SizeConfig.smallImageheight,
                width: SizeConfig.smallImageheight,
                radius: 10,
                imageUrl: widget.product.imageUrl,
              ),
              SizeConfig.horizontalSpaceSmall(),
              Expanded(
                child: SizedBox(
                  height: SizeConfig.smallImageheight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: Text(widget.product.name,style: AppStyles.BlackStyleWithBold800Font_24(context),)),

                          ],
                        ),
                      ),
                      Row(
//                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(title,style: AppStyles.BlackStyleFont_20(context),),
                          SizeConfig.horizontalSpaceSmall(),
                          Text('2 hours',style: AppStyles.GrayStyle_Font16(context),)

                        ],
                      ),
                      SizeConfig.verticalSpaceSmall(),
                      LinearPercentIndicator(
                        padding: EdgeInsets.all(0),
                        width: SizeConfig.screenWidth*.4,
                        lineHeight: 4,
                        percent: widget.product.availableStatus==AvailableStatus.few?0.2:1,
                        backgroundColor: AppColors.lightGreyColor,
                        progressColor: activeColor,
                      ),


                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  InkWell(
                    child:Icon(Icons.add_circle_outline,
                    size: SizeConfig.mediumIconSize,color: AppColors.green,),
//                        Image.asset(widget.product.quantity>0?AssetsPath.green_increment:AssetsPath.increment)),
                    onTap: (){
                      widget.onIncrement();
                    },
                  ),
                  Visibility(
                      visible: widget.product.quantity>0,
                      child: SizeConfig.verticalSpaceSmall()),
                  Visibility(
                      visible: widget.product.quantity>0,
                      child: Text('${widget.product.quantity}')),
                  Visibility(
                      visible: widget.product.quantity>0,
                      child: SizeConfig.verticalSpaceSmall()),
                  Visibility(
                    visible: widget.product.quantity>0,
                    child: InkWell(
                      child: Icon(Icons.remove_circle_outline,size:SizeConfig.mediumIconSize ,color: AppColors.green,),
                      onTap: (){
                        widget.onDecrement();
                      },
                    ),
                  ),


                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
