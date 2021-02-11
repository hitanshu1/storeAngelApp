import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:easy_localization/easy_localization.dart';

class ItemAndChatTabBarWidget extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final bool value;

  ItemAndChatTabBarWidget({
    @required this.onChanged,this.value

  }) : super();

  @override
  _ItemAndChatTabBarWidgetState createState() => _ItemAndChatTabBarWidgetState();
}

class _ItemAndChatTabBarWidgetState extends State<ItemAndChatTabBarWidget>with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  double value = 0.0;

  bool turnState;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: Duration(milliseconds: 400));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    turnState = widget.value;
    _determine();
  }
//  _action() {
//    _determine(changeState: true);
//  }

  _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      (turnState)
          ? animationController.forward()
          : animationController.reverse();
      if (changeState) widget.onChanged(turnState);
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

        onHorizontalDragUpdate: (details){
          if(details.primaryDelta>0){

            animationController.forward();

            turnState=false;
            setState(() {

            });
            widget.onChanged(true);
          }else{


            animationController.reverse();

            turnState=true;
            setState(() {

            });
            widget.onChanged(false);
          }



        },
        child: Container(
          height: SizeConfig.screenHeight*.07,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(SizeConfig.radiusSmall)),
//          padding: EdgeInsets.all(2),
          child: Stack(children: <Widget>[
            Transform.translate(
                offset: Offset(((SizeConfig.screenWidth * 0.5-SizeConfig.sidepadding.left+2) * value - (2 * value)), 0),
                child: Container(
                  height:SizeConfig.screenHeight*.07,
                  width: SizeConfig.screenWidth * 0.5-(SizeConfig.sidepadding.left) ,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SizeConfig.radiusSmall),
                      gradient: AppColors.primaryGradient,
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20.0,
                        ),
                      ]),
                )),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      animationController.reverse();
                      widget.onChanged(false);
                      turnState=true;
                      setState(() {

                      });
//                      _action();
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(StoreangelIcons.grocery_list,color: widget.value?Theme.of(context).textTheme.headline6.color:AppColors.whiteColor,),
                          SizeConfig.horizontalSpaceSmall(),
                          Text(AppStrings.GROCERY_LIST.tr().replaceAll(":", ""),
                            textAlign: TextAlign.center,
                            style: widget.value?AppStyles.GrayStyle_Font20(context):AppStyles.WhiteStyle_Font20,),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      animationController.forward();
                      widget.onChanged(true);
                      turnState=false;
                      setState(() {

                      });
//                      _action();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(AppStrings.CUSTOMER_CHAT.tr(),
                          textAlign: TextAlign.center,
                          style: widget.value?AppStyles.WhiteStyle_Font20:AppStyles.GrayStyle_Font20(context),),
                        SizeConfig.horizontalSpaceSmall(),
                        Icon( StoreangelIcons.chat,color: widget.value?AppColors.whiteColor:Theme.of(context).textTheme.headline6.color,),
                      ],
                    ),
                  ),
                )
              ],
            )
          ]),
        ));
  }

}
