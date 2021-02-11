import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/viewmodel/view_model_pick_new_store.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_mystore.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/shared/premium_card.dart';
import 'package:storeangelApp/ui/shared/view_store.dart';

class NewOrderSelectStore extends StatefulWidget {
  static const String routeName = 'newOrderSelectStoreScreen';

  @override
  _NewOrderSelectStoreState createState() => _NewOrderSelectStoreState();
}

class _NewOrderSelectStoreState extends State<NewOrderSelectStore> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final user=Provider.of<UserModel>(context);

    return BaseView<PickNewStoreViewModel>(
      onModelReady: (pickNewStoreViewModel) {
        pickNewStoreViewModel.initialize(_scrollController,user.id);
      },
      builder: (context, pickNewStoreViewModel, child) {
        return Scaffold(
          appBar: CustomAppBar(
            elevation: pickNewStoreViewModel.hasShadow?4:0,
            leading: BackButton(
              color: Theme.of(context).iconTheme.color,
              onPressed: () {
                pickNewStoreViewModel.navigatorPop();
              },
            ),
            title: Text(
              AppStrings.PICK_A_STORE.tr(),
              style: AppStyles.BlackStyleWithBold800Font_24(context),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: SizeConfig.sidepadding,
            child: Column(
              children: [
                Expanded(
                  flex: 9,
                  child: BaseView<MyStoreViewModel>(
                    onModelReady: (model) => model.getUserStore(user.id),
                    builder: (context, model, child) {
                      if (model.state == ViewState.Busy) {
                        return AppConstants.circulerProgressIndicator();
                      } else {
                        return ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0),
                            itemCount: model.selectedStores.length,
                            itemBuilder: (context, int index) {
                              return Padding(
                                padding: SizeConfig.bottomPadding.copyWith(top: index==0?SizeConfig.verticalMediumPadding.top:0),
                                child: ViewStore(
                                  store: model.selectedStores[index],
                                  newOrder: true,
                                  currentIndex: index,
                                ),
                              );
                            });
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: SizeConfig.screenWidth * .72,
                        child: Text(
                          AppStrings.DO_YOU_WANT_TO_ADD_UNLIMITED_STORES.tr(),
                          style: AppStyles.BlackStyleFontWeightSmall_17(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      PremiumCard(
                        title: AppStrings.GET_PREMIUM_NOW.tr(),
                        imageHeight: 90,
                        subtitle: AppStrings.PREMIUM_SUBTITLE.tr(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
