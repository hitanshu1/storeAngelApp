import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_details_tabone_viewmodel.dart';

import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class OrderCustomerHorizontalListWidget extends StatelessWidget {
  final List<ClientDetails>clients;
  final Function onChangeClient;

  final Function getOpacity;
  OrderCustomerHorizontalListWidget({this.clients,this.onChangeClient,this.getOpacity});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.smallImageheight,
      child: ListView.builder(scrollDirection: Axis.horizontal,
          itemCount: clients.length,
          itemBuilder: (context,int index){
            return Padding(
              padding: index!=0?SizeConfig.smallLeftPadding:EdgeInsets.zero,
              child: InkWell(
                child: Opacity(
                  opacity: getOpacity(clients[index]),
                  child: ViewAppImage(
                    height: SizeConfig.smallImageheight,
                    width:  SizeConfig.smallImageheight,
                    radius:  SizeConfig.smallImageheight,
                    imageUrl: clients[index].imageUrl,
                  ),
                ),
                onTap: (){
                  onChangeClient(clients[index]);
                },
              ),
            );
          }),
    );
  }
}
