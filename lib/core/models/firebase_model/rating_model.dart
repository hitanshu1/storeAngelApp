import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel{
  String ratingID;
  String userID;
  String userRateByID;
  DateTime datRatingOn;
  int rating;
  String review;
  RatingModel({this.userID,this.rating,this.datRatingOn,this.ratingID,this.review,this.userRateByID});

  RatingModel.fromMap(Map snapshot):
        ratingID=snapshot['ID_Rating']??'',
        userID=snapshot['ID_User']??'',
        userRateByID=snapshot['ID_User_Rate_By']??'',
        datRatingOn=snapshot['dat_RatingOn'].runtimeType==Timestamp?snapshot['dat_RatingOn'].toDate():DateTime.parse(snapshot['dat_RatingOn']),
        rating=snapshot['int_Rating'],
        review=snapshot['txt_Review'];

  toJson() {
    return {
      "ID_Rating": ratingID,
      "ID_User":userID,
      "ID_User_Rate_By":userRateByID,
      "dat_RatingOn":datRatingOn,
      "int_Rating":rating,
      "txt_Review":review,

    };
  }
}