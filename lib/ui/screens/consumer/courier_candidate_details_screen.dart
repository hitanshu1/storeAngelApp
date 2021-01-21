import 'package:flutter/material.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/order.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_candidate_details.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customScaffold.dart';
import 'package:storeangelApp/ui/widgets/courier_candidate_details/order_details_widget.dart';
import 'package:storeangelApp/ui/widgets/courier_candidate_details/courier_candidate_header.dart';


class CourierCandidateDetailsArguments{
  final int initialIndex;
  final List<CourierCandidate>candidates;
  final OrderOrPurchases order;
  CourierCandidateDetailsArguments({this.candidates,this.initialIndex,this.order});
}

class CourierCandidateDetailsScreen extends StatelessWidget {
  static const String routeName = 'courierCandidateDetails';
  final CourierCandidateDetailsArguments arguments;
  CourierCandidateDetailsScreen({this.arguments});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BaseView<CourierCandidateDetailsViewModel>(
        onModelReady: (model)=>model.initialiseData(arguments.initialIndex, arguments.candidates),
        builder: (context,model,child){
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: CourierCandidateHeader()),
              SliverToBoxAdapter(
                child: OrderDetailsWidget(candidate: model.currentCandidate,order: arguments.order,),
              ),

            ],
          );
        },
      ),
    );
  }
}
