import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_current_status_widget.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customCard.dart';
import 'package:storeangelApp/ui/shared/view_courier_order_status_widget.dart';
import 'package:storeangelApp/ui/widgets/orderDelivered/order_status_row_widget.dart';

class CourierCurrentStatusWidget extends StatelessWidget {
  final OrderOrPurchases order;
  CourierCurrentStatusWidget({this.order});
  @override
  Widget build(BuildContext context) {
    return BaseView<CourierCurrentStatusViewModel>(
      builder: (context,model,child){
        if(model.state==ViewState.Busy){
          return AppConstants.circulerProgressIndicator();
        }else{
          if(model.expanded){
            return InkWell(
              child: CustomCard(
                child: Padding(
                  padding: SizeConfig.padding,
                  child: Column(
                    children: [
                      SizeConfig.verticalSpaceSmall(),
                      Padding(
                        padding:SizeConfig.sidepadding,
                        child: ViewCourierOrderStatusWidget(order: order,),
                      ),
                      SizeConfig.verticalSpaceSmall(),
                      Padding(
                        padding:SizeConfig.sidepadding,
                        child: OrderStatusRowWidget(status: order.status),
                      ),
                      SizeConfig.verticalSpaceMedium(),
                    ],
                  ),
                ),
              ),
              onTap: (){
                model.toggleExpansion();
              },
            );
          }else{
            return InkWell(
              child:Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(SizeConfig.borderRadius)
                ),
                child: Padding(
                  padding: SizeConfig.padding*1.5,
                  child: Column(
                    children: [
                      Padding(
                        padding:SizeConfig.sidepadding,
                        child: ViewCourierOrderStatusWidget(order: order,),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: (){
                model.toggleExpansion();
              },
            );
          }
        }
      },
    );
  }
}
