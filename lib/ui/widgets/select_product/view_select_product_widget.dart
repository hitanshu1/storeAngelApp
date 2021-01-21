import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/app_sample_data.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/models/product.dart';
import 'package:storeangelApp/ui/shared/quantity_text_filed_widget.dart';
import 'package:storeangelApp/ui/shared/status_dot.dart';
import 'package:storeangelApp/ui/widgets/purchase/purchase_checkbox.dart';

class ViewSelectProductWidget extends StatefulWidget {
  final Product product;
  final bool selected;
  final Function onTap;

  ViewSelectProductWidget({this.product, this.onTap,this.selected:false});

  @override
  _ViewSelectProductWidgetState createState() => _ViewSelectProductWidgetState();
}

class _ViewSelectProductWidgetState extends State<ViewSelectProductWidget> {

  bool enableEntry=false;
  String selectedUnit;



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(border: AppConstants.bottomBorder(context)),
        child: Padding(
          padding: SizeConfig.verticalLarPadding,
          child: Row(
            children: [
              PurchaseCheckBox(
                  status: widget.selected?PurchaseCheckBoxStatus.Selected:PurchaseCheckBoxStatus.Unselected),
              SizeConfig.horizontalSpaceSmall(),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: '${widget.product.name} ',
                    style: AppStyles.BlackStyleFontWeight500_13(context).copyWith(
                      height: 1
                    ),

                  ),
                ),
              ),
              SizeConfig.horizontalSpaceSmall(),
             enableEntry?InkWell(
               onTap: (){
                 setState(() {
                   enableEntry=!enableEntry;
                 });
               },
               child: Row(
                 children: [
                   IconButton(
                     icon: Icon(
                       Icons.remove_circle_outline,
                       color: AppColors.green,
                       size: SizeConfig.screenWidth * .08,
                     ),
                     onPressed: () {
                       if (widget.product.quantity > 1) {
                         widget.product.quantity--;
                         setState(() {});
                       }
                     },
                     iconSize: SizeConfig.screenWidth * .08,
                   ),

                   SizedBox(
                     width: 50,
                     child: QuantityTextFieldWidget(
                       controller: TextEditingController(text:'${widget.product.quantity}' ),
                       onChange: (val){
                         widget.product.quantity=val;
                         setState(() {

                         });
                       },
                     ),
                   ),
                   IconButton(
                     icon: Icon(Icons.add_circle,
                         color: widget.product.quantity > 0
                             ? Theme.of(context).primaryColor
                             : Theme.of(context).primaryColorLight,
                         size: SizeConfig.screenWidth * .08),
                     onPressed: () {
                       widget.product.quantity++;
                       setState(() {

                       });
                     },
                     iconSize: SizeConfig.screenWidth * .08,
                   ),

                   SizedBox(
                     width: 60,
                     child: DropdownButton<String>(
                       isExpanded: true,
                       dropdownColor: Theme.of(context).cardColor,
                       icon: Icon(Icons.expand_more),
                       underline: Container(),
                       hint: Text('Unit',style: AppStyles.BlackStyleFont_20(context),),
                       items: AppSampleData.units.map((modeValue) {
                         return DropdownMenuItem(
                           child: Text(
                             modeValue,
                             style: AppStyles.BlackStyleFont_20(context),
                           ),
                           value: modeValue,
                         );
                       }).toList(),
                       onChanged: (String value) {
                         setState(() {
                           selectedUnit=value;
                         });

                       },
                       value:selectedUnit,
                     ),
                   ),
                 ],
               ),
             ):InkWell(
               onTap: (){
                 setState(() {
                   enableEntry=!enableEntry;
                 });
               },
               child: Row(
                 children: [
                   Text('${widget.product.quantity}', style: AppStyles.BlackStyleFontWeightSmall_12(context)),
                   SizeConfig.horizontalSpaceSmall(),
                   StatusDot(
                     availableStatus: widget.product.availableStatus,
                   )
                 ],
               ),
             )
            ],
          ),
        ),
      ),
    );
  }

}
