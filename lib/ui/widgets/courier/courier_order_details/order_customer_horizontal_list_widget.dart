import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/order_by_store.dart';
import 'package:storeangelApp/ui/shared/circular_image_with_border.dart';
class OrderCustomerHorizontalListWidget extends StatelessWidget {
  final List<ClientDetails>clients;
  final OrderByStore orderByStore;
  final Function onChangeClient;
  final Function getOpacity;
  final bool isSelectAll;
  final Function onSelectAll;
  final Function checkSelected;
  OrderCustomerHorizontalListWidget({this.orderByStore,this.checkSelected,this.clients,this.isSelectAll,this.onChangeClient,this.getOpacity,this.onSelectAll});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.smallImageheight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ListView.builder(scrollDirection: Axis.horizontal,
              itemCount: orderByStore.participants.length,
              shrinkWrap: true,
              itemBuilder: (context,int index){
                return Padding(
                  padding: index!=0?SizeConfig.smallLeftPadding:EdgeInsets.zero,
                  child: GestureDetector(
                    child: CircularImageWithBorder(
                      opacityVal: getOpacity(orderByStore.participants[index].clientDetails),
                        imageUrl: orderByStore.participants[index].clientDetails.imageUrl,
                      isActive: checkSelected( orderByStore.participants[index].clientDetails),
                    ),
                    onTap: (){
                      onChangeClient( orderByStore.participants[index].clientDetails);
                    },
                  ),
                );
              }),
          SizeConfig.horizontalSpaceSmall(),
          ListView.builder(scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: orderByStore.participants.length>3?0:4- orderByStore.participants.length,
              itemBuilder: (context,int index){
                return Padding(
                  padding: index!=0?SizeConfig.smallLeftPadding:EdgeInsets.zero,
                  child: CircularImageWithBorder(
                    opacityVal: .1,
//
                    isActive: false,
                  ),
                );
              }),

        ],
      ),
    );
  }
}
