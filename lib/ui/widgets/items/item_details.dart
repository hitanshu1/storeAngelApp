import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_item_details.dart';
import 'package:storeangelApp/ui/screens/items/alternativeProduct/alternative_product_view.dart';
import 'package:storeangelApp/ui/screens/items/alternativeProduct/find_alternative.dart';
import 'package:storeangelApp/ui/screens/items/alternativeProduct/single_alternative_product_view.dart';
import 'package:storeangelApp/ui/screens/items/item_page_interaction_bar.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/rating_widget.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';
import 'package:storeangelApp/ui/widgets/items/available_widget.dart';

class ArticleDetailsView extends StatefulWidget {
  final Product product;
  final bool courierOption;
  final int currentIndex;

  ///Tells the parent widget that the item has been scroll vertically
  final Function(bool) hasScrolledFunc;

  ArticleDetailsView({
    this.product,
    this.courierOption: false,
    this.currentIndex,
    this.hasScrolledFunc,
  });

  @override
  _ArticleDetailsViewState createState() => _ArticleDetailsViewState();
}

class _ArticleDetailsViewState extends State<ArticleDetailsView> {
  final ScrollController _scrollController = ScrollController();
  int counter = 0;
  bool pieces = true;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (widget.hasScrolledFunc != null) {
        if (_scrollController.position.pixels == 0) {
          widget.hasScrolledFunc(false);
        } else {
          widget.hasScrolledFunc(true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ItemDetailsViewModel>(
      builder: (context, model, child) {
        return SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.sidepadding.left,
                    right: SizeConfig.sidepadding.right,
                    top: SizeConfig.verticalMediumPadding.top),
                child: CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: SizeConfig.adaptiveHeight(SizeConfig.screenHeight * .24),
                        width: SizeConfig.screenWidth,
                        child: ViewAppImage(
                          height: SizeConfig.adaptiveHeight(SizeConfig.screenHeight * .24),
                          width: SizeConfig.screenWidth,
                          imageUrl: widget.product.imageUrl,
                          boxFit: BoxFit.fitHeight,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppConstants.ContainerRoundCorner_Radius),
                            topRight:  Radius.circular(AppConstants.ContainerRoundCorner_Radius),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(AppConstants.ContainerRoundCorner_Radius),
                        ),
                      ),
                      SizeConfig.verticalSpaceESmall(),
                      Padding(
                        padding: SizeConfig.sidepadding,
                        child: Text(
                          widget.product.name,
                          maxLines: 2,
                          style: AppStyles.BlackStyleWithBold800Font_24(context),
                        ),
                      ),
                      SizeConfig.verticalSpaceMedium(),
                      Padding(
                          padding: SizeConfig.sidepadding,
                          child: RatingWidget(
                            objectHeader: AppStrings.PRODUCT_RATING.tr(),
                            objectName: widget.product.name,
                            onRatingUpdate: (val) {},
                          )),
                      SizeConfig.verticalSpaceSmall(),
                    ],
                  ),
                ),
              ),
              SizeConfig.verticalSpaceSmall(),
              Padding(
                padding: SizeConfig.sidepadding,
                child: ItemPageInteractionBar(
                  currentIndex: widget.currentIndex,
                  product: widget.product,
                  onSubmit: () {},
                ),
              ),
              SizeConfig.verticalSpaceSmall(),
              Padding(
                padding: SizeConfig.sidepadding,
                child: CustomCard(
                  child: Padding(
                    padding: SizeConfig.paddingC13,
                    child: AvailableWidget(
                      availableStatus: widget.product.availableStatus,
                      product: widget.product,
                    ),
                  ),

                ),
              ),
              SizeConfig.verticalSpaceSmall(),
              Padding(
                padding: SizeConfig.sidepadding,
                child: CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          model.navigateToScreen(FindAlternativeScreen.routeName,
                              arguments:
                                  FinalAlternativeArgument(product: widget.product, currentIndex: widget.currentIndex));
                        },
                        child: Padding(
                          padding: SizeConfig.sidepadding.copyWith(
                            top: SizeConfig.VerticalSpaceMedium,
                            bottom:SizeConfig.VerticalSpaceMedium,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                size: SizeConfig.smallIconSize,
                                color: AppColors.primaryColor,
                              ),
                              SizeConfig.horizontalSpace(6),
                              AutoSizeText(
                                AppStrings.ALTERNATIVES.tr(),
                                minFontSize: 10,
                                maxFontSize: AppStyles.BlackStyleFont_c16(context).fontSize,
                                style: AppStyles.BlackStyleFont_c16(context),
                                maxLines: 1,
                                textAlign: TextAlign.right,
                              ),
                              Spacer()
                            ],
                          ),
                        ),
                      ),
                      widget.courierOption
                          ? Padding(
                              padding: SizeConfig.sidepadding.copyWith(bottom: SizeConfig.VerticalSpaceMedium),
                              child: Text(
                                AppStrings.COMMON_NOTE.tr(),
                                style: AppStyles.GrayStyle_Font16(context),
                              ),
                            )
                          : Container(),
                      widget.product.alternativeProduct != null
                          ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.all(0),
                              itemCount: widget.product.alternativeProduct.length,
                              shrinkWrap: true,
                              itemBuilder: (context, int index) {
                                return Padding(
                                  padding: SizeConfig.smallerVerticalPadding,
                                  child: AlternativeProductView(
                                    productType: widget.courierOption
                                        ? AlterNativeProductType.CourierScreen
                                        : AlterNativeProductType.CustomerScreen,
                                    product: widget.product.alternativeProduct[index],
                                    quantity: widget.product.alternativeProduct[index].quantity,
                                    selectedAlterNative: widget.product.selectedAlterNative,
                                    increment: () {
                                      if (widget.courierOption) {
                                        if (widget.product.selectedAlterNative != null) {
                                          if (widget.product.selectedAlterNative.id !=
                                              widget.product.alternativeProduct[index].id) {
                                            widget.product.selectedAlterNative =
                                                widget.product.alternativeProduct[index];
                                          } else {
                                            widget.product.selectedAlterNative = null;
                                          }
                                        } else {
                                          widget.product.selectedAlterNative = widget.product.alternativeProduct[index];
                                        }
                                      } else {
                                        widget.product.alternativeProduct[index].quantity++;
                                      }

                                      setState(() {});
                                    },
                                    decrement: () {
                                      if (widget.product.alternativeProduct[index].quantity > 1) {
                                        widget.product.alternativeProduct[index].quantity--;
                                        setState(() {});
                                      } else {
                                        widget.product.alternativeProduct.removeAt(index);
                                        setState(() {});
                                      }
                                    },
                                    onTap: () {
                                      model.navigateToScreen(SingleAlternativeProductView.routeName,
                                          arguments: SingleProductAlternativeScreenArguments(
                                              product: widget.product.alternativeProduct[index],
                                              mainProductsList: widget.product.alternativeProduct,
                                              onTap: () {
                                                widget.product.alternativeProduct.removeAt(index);
                                                setState(() {});
                                              }));
                                    },
                                  ),
                                );
                              })
                          : Container(),
                      widget.product.alternativeProduct != null && (widget.product?.alternativeProduct?.isNotEmpty ?? false)
                          ? SizeConfig.verticalSpaceMedium()
                          : Container()
                    ],
                  ),
                ),
              ),SizeConfig.verticalSpaceMedium(),
            ],
          ),
        );
      },
    );
  }
}
