import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_request.dart';
import 'package:storeangelApp/ui/shared/circular_image_with_border.dart';

class CourierStoreListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CourierRequestViewModel>(
      builder: (context,courierRequestViewModel,child){
        return SizedBox(
          height: SizeConfig.smallImageheight,
          child: ListView.builder(scrollDirection: Axis.horizontal,
              itemCount: courierRequestViewModel.stores.length,
              itemBuilder: (context,int index){
            StoreDataModel store=courierRequestViewModel.stores[index];
                return Padding(
                  padding: index!=0?SizeConfig.smallLeftPadding:EdgeInsets.zero,
                  child: GestureDetector(
                    onTap: (){
                      courierRequestViewModel.onSelectStore(store);
                    },
                    child: CircularImageWithBorder(
                      opacityVal: courierRequestViewModel.storeOpacity(index),
                      isActive: courierRequestViewModel.selectedStore.contains(store),
                      imageUrl:store.image,
                    ),

                  ),
                );
              }),
        );
      },
    );
  }
}
