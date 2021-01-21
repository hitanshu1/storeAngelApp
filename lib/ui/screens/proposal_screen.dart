import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/models/purchase_deatails.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_orderpage.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:storeangelApp/ui/widgets/order_by_store/view_couier_candidate_details.dart';

class ProposalScreen extends StatefulWidget {
  static const String routeName = 'proposalScreen';
  final ProposalScreenArgument argument;

  ProposalScreen({this.argument});

  @override
  _ProposalScreenState createState() => _ProposalScreenState();
}

class _ProposalScreenState extends State<ProposalScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.argument.currentIndex;
    Future.delayed(Duration.zero, () => StatusBarService.changeStatusBarColor(StatusBarType.Gray, context));
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => StatusBarService.changeStatusBarColor(StatusBarType.Gray, context));
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: CustomAppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Theme.of(context).iconTheme.color,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          height: SizeConfig.screenHeight * .04,
          alignment: Alignment.center,
          child: Wrap(
            clipBehavior: Clip.none,
            children: dotWidget(),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: PageView.builder(
                itemCount: widget.argument.candidates.length,
                controller: PageController(initialPage: selectedIndex, keepPage: true, viewportFraction: 1),
                onPageChanged: (int value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
                itemBuilder: (BuildContext context, int itemIndex) {
                  return ViewCourierCandidateDetails(
                    orderOrPurchases: OrderOrPurchases(
                      purchaseDetails: widget.argument.purchaseDatails,
                      candidates:[ widget.argument.candidates[itemIndex]],
                    ),
                  );
                },
              )),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> dotWidget() {
    List<Widget> listWidget = [];
    int length = widget.argument.candidates.length < 40 ? widget.argument.candidates.length : 40;
    for (int i = 0; i < length; i++) {
      listWidget.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedIndex == i ? AppColors.primaryColor : Theme.of(context).cardColor,
          ),
        ),
      );
    }

    return listWidget;
  }
}

class ProposalScreenArgument {
  List<CourierCandidate> candidates;
  int currentIndex;
  OrderPageViewModel model;
  PurchaseDetails purchaseDatails;

  ProposalScreenArgument({this.candidates, this.currentIndex, this.model, this.purchaseDatails});
}
