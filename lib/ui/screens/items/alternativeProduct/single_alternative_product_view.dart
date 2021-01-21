import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/regexService.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_single_alternative_product.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/rating_widget.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/shared/smalltextfield.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/items/available_widget.dart';

class SingleAlternativeProductView extends StatefulWidget {
  static const String routeName = '/singleAlternativeProductView';
  final SingleProductAlternativeScreenArguments arguments;

  SingleAlternativeProductView({this.arguments});



  @override
  _SingleAlternativeProductViewState createState() => _SingleAlternativeProductViewState();
}

class _SingleAlternativeProductViewState extends State<SingleAlternativeProductView> {
  TextEditingController _textController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Dark,context);
    return BaseView<SingleAlterNativeProductViewModel>(
      onModelReady: (singleAlternativeViewModel)=>singleAlternativeViewModel.initialize(_scrollController),
      builder: (context,singleAlternativeViewModel,child){
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: CustomAppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            leading: BackButton(
              color: Theme.of(context).iconTheme.color,
              onPressed: (){
                singleAlternativeViewModel.navigatorPop();
              },
            ),
            elevation: singleAlternativeViewModel.hasShadow?4:0,
          ),
          body: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(30)),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: SizeConfig.sidepadding.copyWith(top: SizeConfig.verticalMediumPadding.top),
                    child: CustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: SizeConfig.screenHeight * .24,
                            width: SizeConfig.screenWidth,
                            child: ViewAppImage(
                              height: SizeConfig.screenHeight * .24,
                              width: SizeConfig.screenWidth,
                              imageUrl: widget.arguments.product.imageUrl,
                              boxFit: BoxFit.cover,
                              borderRadius:BorderRadius.only(
                                topRight: Radius.circular(SizeConfig.borderRadius),
                                topLeft: Radius.circular(SizeConfig.borderRadius),
                              ) ,

                            ),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(SizeConfig.borderRadius),
                            ),
                          ),
                          SizeConfig.verticalSpaceESmall(),
                          Padding(
                            padding: SizeConfig.sidepadding,
                            child: Text(
                              widget.arguments.product.name,
                              style: AppStyles.BlackStyleWithBold800Font_24(context),
                            ),
                          ),
                          SizeConfig.verticalSpaceSmall(),
                          Padding(
                            padding: SizeConfig.sidepadding,
                            child: RatingWidget(
                              objectHeader: AppStrings.PRODUCT_RATING.tr(),
                              objectName: widget.arguments.product.name,
                              onRatingUpdate: (val){},
                            ),
                          ),
                          SizeConfig.verticalSpaceSmall(),
                        ],
                      ),
                    ),
                  ),

                  SizeConfig.verticalSpaceSmall(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: itemCard(singleAlternativeViewModel),
                  ),
                  SizeConfig.verticalSpaceSmall(),
                  Padding(
                    padding: SizeConfig.sidepadding,
                    child: CustomCard(
                      child: Padding(
                        padding: SizeConfig.paddingC13,
                        child: AvailableWidget(
                          availableStatus: widget.arguments.product.availableStatus,
                          product: widget.arguments.product,
                        ),
                      ),
                    ),
                  ),
                  SizeConfig.verticalSpace(SizeConfig.screenHeight * .05)
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget itemCard(SingleAlterNativeProductViewModel model){
    return CustomCard(
      child: Container(
        height: 110,
        width: SizeConfig.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: SizeConfig.sidepadding,
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          child: Text(
                            AppStrings.ADD_AS_ALTERNATIVES.tr(),
                            style: AppStyles.BlackStyleFont_20(context),
                          ),
                          onTap: (){

                            if( widget.arguments.mainProductsList.contains(widget.arguments.product)){

                              model.navigatorPop();
                            }else{
                              widget.arguments.onTap();
                              setState(() {

                              });
                            }
                          },
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: SizeConfig.screenWidth * .25,
                        height: SizeConfig.adaptiveHeight(SizeConfig.screenHeight*.05),
                        child: SmallTextField(
                          controller: _textController,
                          hintText: AppStrings.YOUR_ESTIMATE.tr(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          textInputAction: TextInputAction.done,
                          enableSuffixIfTextIsNotEmpty: true,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegexService.doubleRegexWithCommaOrDotAndTwoDigit),
                          ],
                          textInputType: TextInputType.numberWithOptions(signed: true, decimal: true),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: Icon(widget.arguments.mainProductsList != null &&
                              widget.arguments.mainProductsList.contains(widget.arguments.product)
                              ? Icons.remove_circle_outline
                              : Icons.add_circle_outline,
                          size: SizeConfig.screenWidth*.11,
                          color: Theme.of(context).primaryColor,
                        ),
                        onTap: () {
                          widget.arguments.onTap();
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  SizeConfig.horizontalSpaceSmall(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleProductAlternativeScreenArguments {
  Product product;
  List<Product> mainProductsList;
  Function onTap;

  SingleProductAlternativeScreenArguments({this.product, this.mainProductsList, this.onTap});
}
