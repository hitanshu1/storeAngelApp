import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

import 'package:storeangelApp/core/models/firebase_storedata_model.dart';
import 'package:storeangelApp/ui/shared/view_app_Image.dart';

class CourierStoreListWidget extends StatelessWidget {
  final List<StoreDataModel>stores;
  CourierStoreListWidget({this.stores});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.smallImageheight,
      child: ListView.builder(scrollDirection: Axis.horizontal,
          itemCount: stores.length,
          itemBuilder: (context,int index){
        return Padding(
          padding: index!=0?SizeConfig.smallLeftPadding:EdgeInsets.zero,
          child: SizedBox(
            child: ViewAppImage(
              height: SizeConfig.smallImageheight,
              width:  SizeConfig.smallImageheight,
              radius:  SizeConfig.smallImageheight,
              imageUrl: stores[index].image,
            ),
          ),
        );
      }),
    );
  }
}
