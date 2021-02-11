import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/viewmodel/view_model_courier_item_details.dart';
import 'package:storeangelApp/ui/shared/circular_image_with_border.dart';

class ClientListWidget extends StatelessWidget {
  final List<ClientDetails>clients;
  ClientListWidget({this.clients});
  @override
  Widget build(BuildContext context) {
    return   Consumer<CourierItemDetailsViewModel>(builder: (context,model,child){
      return SliverToBoxAdapter(
        child: Padding(
          padding: SizeConfig.paddingWithHighVerticalSpace,
          child:  SizedBox(
            height: SizeConfig.smallImageheight,
            child: ListView.builder(scrollDirection: Axis.horizontal,
                itemCount: clients.length,
                shrinkWrap: true,
                itemBuilder: (context,int index){
                  return Padding(
                    padding: index!=0?SizeConfig.smallLeftPadding:EdgeInsets.zero,
                    child: InkWell(
                      onTap: (){
                        model.onSelectClient(clients[index]);
                      },
                      child: CircularImageWithBorder(
                        opacityVal: 1,
                        imageUrl: clients[index].imageUrl,
                        isActive: model.selectedClients.contains(clients[index]),
                      ),
                    ),
                  );
                }),
          ),
        ),
      );
    });
  }
}
