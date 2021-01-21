import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order_productlist.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/widgets/items/item_details.dart';

class CourierOrderProductListArgument{
  List<Product>products;
  int currentIndex;
  CourierOrderProductListArgument({this.products,this.currentIndex});
}

class CourierOrderProductListScreen extends StatefulWidget {
  static const String routeName = 'courierOrderProductListScreen';
  final CourierOrderProductListArgument argument;

  CourierOrderProductListScreen({this.argument});


  @override
  _CourierOrderProductListScreenState createState() => _CourierOrderProductListScreenState();
}

class _CourierOrderProductListScreenState extends State<CourierOrderProductListScreen> {
  int selectedIndex=0;
  int counter=0;
  bool pieces=true;

  @override
  void initState() {
    super.initState();
    if(widget.argument.currentIndex!=null){
      selectedIndex=widget.argument.currentIndex;
      setState(() {

      });
    }
  }



  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Gray,context);
    final theme=Theme.of(context);
    return BaseView<CourierOrderProductListViewModel>(
      builder: (context,model,child){
        return Scaffold(

          body:Column(

            children: [
              SizeConfig.CVerticalSpaceBig(),
              Row(
                children: [
                 BackButton(
                  color: Theme.of(context).iconTheme.color,onPressed: (){
                   model.navigatorPop();
                 },),
                  Expanded(
                    child: Container(
                      height: SizeConfig.screenHeight*.04,
                      child:widget.argument.products.length>1? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.argument.products.map((url) {
                          int index = widget.argument.products.indexOf(url);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedIndex == index
                                  ? Theme.of(context).primaryColor
                                  : theme.primaryColorLight,
                            ),
                          );
                        }).toList(),
                      ):Container(),
                    ),
                  ),
                  Opacity(
                    opacity: 0,
                    child: BackButton(
                  color: Theme.of(context).iconTheme.color,)
                  ),
                ],
              ),
              Expanded(
                child: CarouselSlider(
                  options: CarouselOptions(

                      height: SizeConfig.screenHeight*.91,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason){
                        setState(() {
                          selectedIndex=index;
                        });

                      }
                    // autoPlay: false,
                  ),
                  items: widget.argument.products.map((product) => ArticleDetailsView(product:product,courierOption: true,)).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
