import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';

class ViewBillList extends StatelessWidget {
  final List<File>images;
  final List imageUrls;
  final Function onClose;
  final Function onDelete;
  bool enableDelete;
  ViewBillList({this.onClose,this.images,this.onDelete,this.imageUrls,this.enableDelete:true});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClose,
      child: Container(
//        color: Colors.black.withOpacity(.3),
      color: Theme.of(context).disabledColor,
        child: Center(
          child: InkWell(
            onTap: (){
            },
            child: Container(
              height: SizeConfig.screenHeight*.6,
              color: Colors.transparent,
              child: ListView.builder(itemCount: images!=null?images.length:imageUrls.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,int index){
                return Padding(
                  padding:SizeConfig.sidelargepadding,
                  child: Stack(
                    children: [
                      images!=null?Container(
                        height: SizeConfig.screenHeight*.6,
                        width: SizeConfig.screenWidth*.7,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:FileImage(images[index]),
                                fit: BoxFit.contain),
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(SizeConfig.borderRadius)
                        ),
                      ):Container(
                        height: SizeConfig.screenHeight*.6,
                        width: SizeConfig.screenWidth*.7,
                        child: CachedNetworkImage(
                          imageUrl: imageUrls[index],
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Container(
                            width: SizeConfig.screenHeight * .1,
                            height: SizeConfig.screenHeight * .1,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
//                          image: DecorationImage(
//                              image: images!=null?FileImage(images[index]):NetworkImage(imageUrls[index]),
//                          fit: BoxFit.contain),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(SizeConfig.borderRadius)
                        ),
                      ),
                      enableDelete?Positioned.fill(child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(icon:Icon(Icons.delete), onPressed:(){
                          onDelete(index);
                        }),
                      )):Container()
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
