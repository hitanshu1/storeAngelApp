import 'package:storeangelApp/core/enums/varify_status.dart';
import 'package:storeangelApp/core/models/rating_model.dart';

class CourierCandidate {
  String id;
  String name;
  String imageUrl;
  int completedOrders;
  int stars;
  int reviews;
  int totalOrder;
  VerifyStatus verifyStatus;
  bool insurance;
  double charge;
  String phoneNumber;
  String time;
  DateTime date;
  bool favourite;
  String status;
  bool approved;
  bool insured;
  bool reliable;
  List<RatingModel>ratings;

  CourierCandidate(
      {this.name,
      this.imageUrl,
      this.reviews,
      this.stars,
      this.completedOrders,
      this.favourite:false,
      this.totalOrder,
      this.verifyStatus,
      this.insurance,
      this.charge:10,
      this.phoneNumber,
      this.time,
      this.status,
        this.ratings,
        this.date,
      this.id,this.approved:false,this.insured:false,this.reliable:false});
}
