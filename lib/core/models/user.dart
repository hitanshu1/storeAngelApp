import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storeangelApp/core/enums/share_status.dart';

class UserModel {
  String adminStoreId;
  String id;
  List arrayAngelAt;
  bool disable;
  bool premium;
  DateTime changeDate;
  DateTime createdDate;
  String addressLine;
  String city;
  String country;
  String street;
  String email;
  String name;
  String phone;
  String state;
  String userName;
  String firstName;
  String lastName;
  String imageUrl;
  String userType;
  ShareStatus status;
  String zipCode;
  int verify;
  Timestamp t;
  bool isPremium;

  UserModel(
      {this.street,
      this.city:'Hauptstraße 37',
      this.name,
      this.id,
      this.imageUrl,
      this.userType,
      this.status,
      this.firstName,

        this.country='Nümbrecht',
      this.lastName,
      this.verify,
        this.zipCode:'',
      this.addressLine,this.isPremium:false});

  UserModel.fromMap(Map snapshot)
      : id = snapshot['ID_User'],
        adminStoreId = snapshot['ID_Store_Adm'],
        arrayAngelAt = snapshot['array_AngelAt'],
        disable = snapshot['bit_Disabled'] ?? false,
        premium = snapshot['bit_Premium'] ?? false,
        changeDate = snapshot['dat_Changedate'].runtimeType==Timestamp? snapshot['dat_Changedate'].toDate() : null,
        createdDate = snapshot['dat_Createdate'].runtimeType==Timestamp? snapshot['dat_Createdate'].toDate() : null,
        city = snapshot['txt_City'] ?? '',
        country = snapshot['txt_Country'] ?? '',
        addressLine = snapshot['addressLine'] ?? '',
        email = snapshot['txt_Email'] ?? '',
        name = snapshot['txt_Name'] ?? "",
        phone = snapshot['txt_Phone'] ?? "",
        state = snapshot['state'] ?? "",
        userName = snapshot['userName'] ?? "",
        imageUrl = snapshot['imageUrl'] ?? "",
        firstName = snapshot['firstName'] ?? '',
        lastName = snapshot['lastName'] ?? '',
        street = snapshot['street'] ?? '',
        verify = snapshot['verify'] ?? 0,
        userType = snapshot['userType'] ?? "";

  toJson() {
    return {
      "ID_User": id,
      "ID_Store_Adm": adminStoreId,
      "array_AngelAt": arrayAngelAt ?? [],
      "bit_Disabled": disable ?? false,
      "bit_Premium": premium ?? false,
      "dat_Changedate": DateTime.now(),
      "dat_Createdate": createdDate ?? DateTime.now(),
      "txt_City": city,
      "addressLine": addressLine,
      "txt_Country": country,
      "txt_Email": email,
      "txt_Name": name,
      "txt_Phone": phone,
      "txt_State": state,
      "txt_Username": userName,
      'firstName': firstName,
      'lastName': lastName,
      'verify': verify
    };
  }

  String get addressLinen => zipCode +' '+ city+'\n'+country;
  String get addressLines=> street+' '+city+'\n'+zipCode+' '+country;

  String get zipCoden => zipCode+' '+city;
}
