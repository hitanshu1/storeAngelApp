import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/ui/shared/customer_header_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class YourUserListHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: CustomerHeader(
        isBack: true,
        title:AppStrings.YOUR_FRIENDS.tr(),
        actions: [
          IconButton(icon: Icon(Icons.add,color: AppColors.whiteColor,),
              onPressed: (){

              })
        ],


      ),
    );
  }
}
