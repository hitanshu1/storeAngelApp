import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/numberService.dart';
import 'package:storeangelApp/core/viewmodel/selectAddress_viewmodel.dart';

class SearchProductList extends StatelessWidget {
  final List<Product> products;
  final TextEditingController controller;
  final bool dataNull;
  final Function onSelect;
  final ScrollController scrollController;

  SearchProductList(
      {this.products,this.controller,this.dataNull,this.onSelect, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: products.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        return Consumer<SelectAddressViewModel>(
          builder: (context, model, child) => GestureDetector(
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  AppConstants.TextField_Contentpading_top, AppConstants.TextField_Contentpading_top, 0, 0),
              child: Column(
                children: <Widget>[
                  Divider(
                    color: AppColors.darkGrayColor,
                  ),
                  SizeConfig.VerticalSpaceSmallMedium(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                          flex: 1,
                          child: Icon(
                            Icons.search,
                            color: AppColors.darkGrayColor,
                            size: AppConstants.imageHeight_width,
                          )),
                      Container(
                        padding: EdgeInsets.all(AppConstants.marginVerySmall1),
                      ),
                      Flexible(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              products[index].name,
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: AppStyles.BlackStyleFont_20(context),
                            ),
                            SizeConfig.verticalSpaceSmall(),
                            Text(
                             '${NumberService.priceAfterConvert(products[index].price,context)}',
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              style: AppStyles.darkGrayLittleStyle_Font10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () {
              onSelect(products[index].name);
            },
          ),
        );
      },
    );
  }
}
