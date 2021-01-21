import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_save_articles.dart';
import 'package:storeangelApp/ui/screens/consumer/share_list_screen.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/title_text_widget.dart';
import 'package:storeangelApp/ui/widgets/save_articles/articles_list_widget.dart';
import 'package:storeangelApp/ui/widgets/save_articles/articles_order_details_widget.dart';

import '../contract_conditions_screen.dart';
import 'item_search_screen.dart';


class SaveArticlesScreen extends StatelessWidget {
  static const String routeName = 'saveArticlesScreen';
  final PurchaseDetails purchaseDetails;
  SaveArticlesScreen({this.purchaseDetails});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BaseView<SaveArticlesViewModel>(
        builder: (context,model, child){
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AppHeader(
                  isBack: true,
                  title: AppStrings.YOUR_SHOPPING_LISTS.tr(),
                  actions: [
                    IconButton(icon: Icon(Icons.add,color: AppColors.whiteColor,),
                        onPressed: (){
                          model.navigateToScreen(ShareListScreen.routeName);
                        })
                  ],
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: ArticleOrderDetailsWidget(
                    purchaseDetails: purchaseDetails,
                  ),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child:Padding(
                  padding: SizeConfig.sidepadding,
                  child: TitleTextWidget(
                    title: AppStrings.SAVED_ARTICLES.tr(),
                  ),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: Text(AppStrings.SELECT_ALL_OF_THE_ITEMS.tr(),
                    style: AppStyles.BlackStyleFont_20(context),),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              ArticlesListWidget(products: purchaseDetails.products,
              showNewPrice: true,isItalicFont: false,),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: ButtonWidget(
                    buttonText: AppStrings.HIRE_A_COURIER.tr(),
                    onPressed: (){
                      model.navigateToScreen(ContractConditionsScreen.routeName,
                          arguments: purchaseDetails);
                    },
                  ),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: SizeConfig.sidepadding,
                  child: ButtonWidget(
                    gradient: AppColors.blackGradient,
                    buttonText: AppStrings.GO_SHOPPING.tr(),
                    onPressed: (){
                      model.navigateToScreen(ItemSearchScreen.routeName);
                    },
                  ),
                ),
              ),
              SizeConfig.verticalSliverSmallSpace(),

            ],
          );
        },
      ),
    );
  }
}
