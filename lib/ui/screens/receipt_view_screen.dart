import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/storeangel_icons_icons.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_receipt_view.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:easy_localization/easy_localization.dart';

class ReceiptViewScreen extends StatefulWidget {
  static const String routeName = 'receiptViewScreen';
  final List receipts;
  ReceiptViewScreen({this.receipts});

  @override
  _ReceiptViewScreenState createState() => _ReceiptViewScreenState();
}

class _ReceiptViewScreenState extends State<ReceiptViewScreen> {

  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return BaseView<ReceiptViewModel>(
      builder: (context,model,child){
        return Scaffold(
          appBar: CustomAppBar(
            backgroundColor: Theme.of(context).cardColor,
             leading: BackButton(
              color: Theme.of(context).iconTheme.color,
          onPressed: () {
            model.navigatorPop();
          },
        ),
            title:Text(AppStrings.RECEIPT_VIEW.tr(),
              style: AppStyles.BlackStyleWithBold800Font_24(context),
              textAlign: TextAlign.center,) ,
            actions: [
              IconButton(
                icon: Icon(
                  StoreangelIcons.download_icon,
                  color: Theme.of(context).focusColor,
                ),
                onPressed: () => null,
              ),
            ],

          ),
          body: Column(
            children: [
              SizeConfig.verticalSpaceSmall(),

              SizedBox(
                height: 20,
                child: ListView.builder(shrinkWrap: true,itemCount: widget.receipts.length,scrollDirection: Axis.horizontal,itemBuilder: (context,int index){
                  return Padding(
                    padding:  EdgeInsets.only(right: 5),
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex==index?Colors.green:Colors.white
                      ),
                    ),
                  );
                }),
              ),
              SizeConfig.verticalSpaceSmall(),
              Expanded(
                child: CarouselSlider.builder(itemCount: widget.receipts.length,
                    options: CarouselOptions(
                      initialPage: currentIndex,
                      enableInfiniteScroll: false,

                      height: SizeConfig.screenHeight * .91,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      onPageChanged: (index, reason) {
                       setState(() {
                         currentIndex = index;
                       });
                      },
                      // autoPlay: false,
                    ),
                    itemBuilder: (context,int index){

                  return  Container(
                    width: SizeConfig.screenWidth,
                    child: PhotoView(
                      backgroundDecoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor
                      ),
                      imageProvider: NetworkImage(widget.receipts[index],),
                      loadingBuilder: (context, event) => Center(
                        child:AppConstants.circulerProgressIndicator()),
                      ),

                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
