import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/participant.dart';
import 'package:storeangelApp/ui/shared/app_header.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/ui/shared/clipper/receipt_clipper.dart';
import 'package:storeangelApp/ui/widgets/receipt_screen/receipt_information_widget.dart';

class ReceiptScreen extends StatelessWidget {
  static const routeName='receiptScreen';
  final Participant participant;
  ReceiptScreen({this.participant});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AppHeader(
              isBack: true,
              height: SizeConfig.smallHeaderSize,
              title: AppStrings.RECEIPT.tr(),
            ),
          ),

          SizeConfig.verticalSliverSmallSpace(),

          SliverToBoxAdapter(
            child: Padding(
              padding:SizeConfig.padding,
              child: ClipPath(
                clipper: ReceiptClipper(),
                child: Container(
                  child: ReceiptInformationWidget(
                    participant: participant,
                  ),
                  width: SizeConfig.screenWidth,
                  color: AppColors.whiteColor,

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
