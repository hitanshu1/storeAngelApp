import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/participant.dart';
import 'package:storeangelApp/core/models/user.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_details_tabone_viewmodel.dart';
import 'package:storeangelApp/ui/shared/circular_image_with_border.dart';
import 'package:storeangelApp/ui/shared/unread_meassge_number_widget.dart';
class CourierOrderDetailsTabOneClientListWidget extends StatelessWidget {
  final List<ClientDetails>clients;
  final List<Participant>participants;
  final Function onChangeClient;
  final Function getOpacity;
  final bool isSelectAll;
  final Function onSelectAll;
  final Function checkSelected;
  CourierOrderDetailsTabOneClientListWidget({this.participants,this.checkSelected,this.clients,this.isSelectAll,this.onChangeClient,this.getOpacity,this.onSelectAll});
  @override
  Widget build(BuildContext context) {
    UserModel user=Provider.of<UserModel>(context);
    return Consumer<CourierOrderDetailsTabOneViewModel>(builder: (context,model,child){
      return SizedBox(
        height: SizeConfig.smallImageheight,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ListView.builder(scrollDirection: Axis.horizontal,
                itemCount: participants.length,
                shrinkWrap: true,
                itemBuilder: (context,int index){
                  return Padding(
                    padding: index!=0?SizeConfig.smallLeftPadding:EdgeInsets.zero,
                    child: GestureDetector(
                      child: StreamBuilder<int>(stream: model.clientUnreadMessage(user.id, clients[index].id),
                          builder: (context,snapshot){
                        print(snapshot.connectionState);
                        print(snapshot.hasData);
                        if(snapshot.hasData){
                          return Stack(
                            children: [
                              CircularImageWithBorder(
                                opacityVal: getOpacity( participants[index].clientDetails),
                                imageUrl: participants[index].clientDetails.imageUrl,
                                isActive: checkSelected( participants[index].clientDetails),
                              ),
                              Positioned.fill(child: Align(
                                alignment: Alignment.topRight,
                                child:UnreadMessageNumberWidget(
                                  totalMessage: snapshot.data,
                                ),
                              ))
                            ],
                          );
                        }
                        return CircularImageWithBorder(
                          opacityVal: getOpacity( participants[index].clientDetails),
                          imageUrl: participants[index].clientDetails.imageUrl,
                          isActive: checkSelected( participants[index].clientDetails),
                        );
                      }),
                      onTap: (){
                        onChangeClient( participants[index].clientDetails);
                      },
                    ),
                  );
                }),
            SizeConfig.horizontalSpaceSmall(),
            ListView.builder(scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount:  participants.length>3?0:4-participants.length,
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
    });
  }
}
