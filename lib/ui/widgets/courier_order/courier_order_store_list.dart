import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order.dart';
import 'package:storeangelApp/ui/shared/circular_image_with_border.dart';

class CourierOrderStoreListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CourierOrderViewModel>(
      builder: (context,courierOrderViewModel,child){
        return SizedBox(
          height: SizeConfig.smallImageheight,
          child: ListView.builder(scrollDirection: Axis.horizontal,
              itemCount: courierOrderViewModel.stores.length,
              itemBuilder: (context,int index){
                StoreDataModel store=courierOrderViewModel.stores[index];
                return Padding(
                  padding: index!=0?SizeConfig.smallLeftPadding:EdgeInsets.zero,
                  child: GestureDetector(
                    onTap: (){
                      courierOrderViewModel.onSelectStore(store,index);
                    },

                    child: CircularImageWithBorder(
                      opacityVal: courierOrderViewModel.storeOpacity(index) ,
                      isActive:courierOrderViewModel.selectedStore.contains(store),
                      imageUrl:store.image ,
                      height: SizeConfig.smallImageheight,
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
