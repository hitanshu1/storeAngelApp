import 'package:flutter/material.dart';
import 'package:storeangelApp/core/enums/available_status.dart';
import 'package:storeangelApp/core/models/product.dart';
class CircleWidget extends StatefulWidget {
  final Color color;
  final double height,width;
  final AvailableStatus availableStatus;
  final List<Product>products;
  final TextStyle style;

  CircleWidget({this.color,this.height,this.width,this.availableStatus,this.products,this.style});

  @override
  _CircleWidgetState createState() => _CircleWidgetState();
}

class _CircleWidgetState extends State<CircleWidget> {
  int counter=0;


  @override
  void initState() {
    super.initState();
    widget.products.forEach((pelement) {
      if(pelement.availableStatus==widget.availableStatus){
        setState(() {
          counter+=pelement.quantity;
        });
      }

    });

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.color
      ),
      child: Center(
        child: Text('$counter',style: widget.style, textAlign: TextAlign.center,),
      ),
    );
  }
}
