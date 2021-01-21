class ProductRating {
  String productID;
  String userID;
  String rating;
  ProductRating({this.rating,this.userID,this.productID});
  ProductRating.fromMap(Map snapshot):
        productID=snapshot['ID_Product']??'',
        userID=snapshot['ID_User']??'',
        rating=snapshot['txt_Rating'];

  toJson() {
    return {
      "ID_Product": productID,
      "ID_User":userID,
      "txt_Rating":rating,

    };
  }

}