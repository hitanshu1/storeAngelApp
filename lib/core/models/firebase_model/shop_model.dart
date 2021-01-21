class ShopModel{
  String fromCopiedShopListID;
  String shopListID;
  String storeID;
  String userID;
  bool bitDisabled;
  bool bitPublic;
  DateTime dateChange;
  DateTime createdDate;
  String shareCount;
  int sortValue;
  String lastName;
  String userImage;
  String userName;
  String docID;

  ShopModel({this.storeID,this.bitDisabled,this.userID,this.shopListID,this.lastName,this.userName,this.bitPublic,this.createdDate,
  this.dateChange,this.fromCopiedShopListID,this.shareCount,this.sortValue,this.userImage,this.docID});
  ShopModel.fromMap(Map snapshot,String docID):
      docID=docID,
      fromCopiedShopListID=snapshot['ID_FromCopiedShopList']??'',
        shopListID=snapshot['ID_Shop_List']??'',
        storeID=snapshot['ID_Store']??'',
        userID=snapshot['ID_User']??'',
        bitDisabled=snapshot['bit_Disabled']??false,
        bitPublic=snapshot['bit_Public']??false,
        dateChange=snapshot['dat_ChangeDate'].runtimeType!=String?snapshot['dat_ChangeDate'].toDate():DateTime.parse(snapshot['dat_ChangeDate']),
  createdDate=snapshot['dat_CreateDate'].runtimeType!=String?snapshot['dat_CreateDate'].toDate():DateTime.parse(snapshot['dat_CreateDate']),
  shareCount=snapshot['int_ShareCount']??'',
        sortValue=snapshot['int_Sortvalue']??0,
  lastName=snapshot['txt_Listname']??'',
        userImage=snapshot['txt_UserImage'],
        userName=snapshot['txt_Username'];

  toJson() {
    return {
      "ID_FromCopiedShopList": fromCopiedShopListID,
      "ID_Shop_List":shopListID,
      "ID_Store":storeID,
      "ID_User":userID,
      "bit_Disabled":bitDisabled,
      "bit_Public":bitPublic,
      "dat_ChangeDate":dateChange,
      "dat_CreateDate":createdDate,
      "int_ShareCount":shareCount,
      "int_Sortvalue":sortValue,
      "txt_Listname":lastName,
      "txt_UserImage":userImage,
      "txt_Username":userName


    };
  }


}