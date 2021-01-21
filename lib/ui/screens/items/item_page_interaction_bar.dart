
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/enums/available_status.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/regexService.dart';
import 'package:storeangelApp/core/viewmodel/common_itemsscreen_viewmodel.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/customstatuscheckbox.dart';
import 'package:storeangelApp/ui/shared/smalltextfield.dart';

class ItemPageInteractionBar extends StatefulWidget {
  final Product product;
  final int currentIndex;
  final Function onSubmit;

  ItemPageInteractionBar({this.product, this.currentIndex, this.onSubmit});

  @override
  _ItemPageInteractionBarState createState() => _ItemPageInteractionBarState();
}

class _ItemPageInteractionBarState extends State<ItemPageInteractionBar> {
  int counter = 0;
  bool pieces = true;
  TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CommonItemScreenViewModel>(context);
    return CustomCard(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
//              Text(AppStrings.NUMBER.tr()+':', style: AppStyles.BlackStyleFont_20(context),),
              SizeConfig.horizontalSpace(SizeConfig.screenWidth*.02),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.add_circle,
                            color: widget.product.quantity > 0
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).primaryColorLight,
                            size: SizeConfig.screenWidth * .08),
                          onPressed: () {
                            widget.product.quantity++;
                            model.setState(ViewState.Idle);
                            setState(() {});
                          },
                        iconSize: SizeConfig.screenWidth * .08,
                      ),
                      SizeConfig.verticalSpaceVerySmall(),
                      SizedBox(
                        width: 20,
                        child: Center(
                          child: Text(
                            '${widget.product.quantity}',
                            style: AppStyles.BlackStyleWithBold800Font_20(context),
                          ),
                        ),
                      ),
                      SizeConfig.verticalSpaceVerySmall(),
                      IconButton(
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: AppColors.green,
                          size: SizeConfig.screenWidth * .08,
                        ),
                        onPressed: () {
                          if (widget.product.quantity > 1) {
                            widget.product.quantity--;
                            setState(() {});
                          }
                        },
                        iconSize: SizeConfig.screenWidth * .08,
                      ),
                    ],
                  ),
              SizeConfig.horizontalSpace(SizeConfig.screenWidth*.02),
              SizedBox(
                width: SizeConfig.screenWidth * .2,
                height: SizeConfig.adaptiveHeight(SizeConfig.screenHeight*.05),
                child: SmallTextField(
                  controller: _textController,
                  hintText: '0,00',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  textInputAction: TextInputAction.done,
                  enableSuffixIfTextIsNotEmpty: true,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegexService.doubleRegexWithCommaOrDotAndTwoDigit),
                  ],
                  textInputType: TextInputType.numberWithOptions(signed: true, decimal: true),
                ),
              ),
              SizeConfig.horizontalSpace(SizeConfig.sidepadding.left),
              Spacer(),
              CustomStatusCheckBox(
                status: AvailableStatus.unknown,
                size: SizeConfig.screenWidth * .15,
                iconSize: SizeConfig.screenWidth*.10,
              ),
              Spacer()
            ],
          ),
        ],
      ),
    );
  }
}
