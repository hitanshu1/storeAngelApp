
import 'package:storeangelApp/core/models/rating_model.dart';
import 'package:storeangelApp/core/models/user.dart';

enum PaymentType{Prepaid,PayOnDelivery,Both}

class StoreDataModel {
  String id;
  String name;
  String street;
  String steetNo;
  String city;
  String txtZip;
  String district;
  String country;
  String openingTime;
  String closingTime;
  String image;
  String documentId;
  String landMark;
  bool isChecked;
  String webSitUrl;
  int likes;
  List<UserModel>topList;
  List<RatingModel>ratings;
  PaymentType paymentType;
  // String created;

  StoreDataModel(
      {this.id,
      this.isChecked: false,
      this.webSitUrl: '',
        this.steetNo:'',
      this.name: '',
      this.city: '',
      this.street: '',
      this.landMark,
      this.txtZip: '',
      this.country: 'Wiehl',
      this.image,
      this.documentId,
      this.openingTime,
      this.likes,
        this.topList,
        this.district:"PetzWiesenstraße",
      this.closingTime,this.ratings,this.paymentType:PaymentType.Prepaid});

  String get fullAddress=>name+', '+street+', '+city+', '+txtZip;
  String get twoLineAddress=>name+' '+street+'\n'+city+' '+district+'\n'+txtZip+' '+country;
  String get twoLineAddressWithoutName=>street+'\n'+txtZip+', '+city;

  String get zipCity => txtZip + ' ' + city;

  String get address => street + ', ' + txtZip + ' ' + city;
}
