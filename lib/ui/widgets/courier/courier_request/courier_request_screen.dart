import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_request.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/shared/premium_widget.dart';
import 'courier_store_list_widget.dart';
import 'view_courier_order_widget.dart';


class CourierRequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BaseView<CourierRequestViewModel>(
        onModelReady: (model) => model.getAssignOrderList('courierId'),
        builder: (context, courierRequestViewModel, child) {
          if (courierRequestViewModel.state == ViewState.Busy) {
            return AppConstants.circulerProgressIndicator();
          } else {

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: AppHeader(
                    height: SizeConfig.smallHeaderSize,
                    title:AppStrings.CUSTOMER_INQUIRIES.tr() ,
                    isSort: true,


                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: SizeConfig.paddingWithHighVerticalSpace,
                    child: CourierStoreListWidget(stores: courierRequestViewModel.stores,),
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, int index) {

                        return Padding(
                          padding: SizeConfig.sidepadding,
                          child: InkWell(
                            child: ViewCourierOrderWidget(
                              order: courierRequestViewModel.assignOrders[index],
                            ),
                            onTap: ()async{
                              await courierRequestViewModel.navigatetoOrderInformationScreen(index);
                            },
                          ),
                        );
                      },
                      childCount: courierRequestViewModel.assignOrders.length,
                    )),
                SliverToBoxAdapter(
                  child: PremiumWidget(),
                ),


              ],
            );

          }
        },
      ),
    );
  }


}
