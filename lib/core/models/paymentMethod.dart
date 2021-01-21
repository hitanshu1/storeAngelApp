class PaymentMethod{
  String imageUrl;
  String title;
  PaymentMethod({this.imageUrl,this.title});

  factory PaymentMethod.fromMap(Map<dynamic, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String imageUrl = data['imageUrl'];
    final String title=data['title'];

    return PaymentMethod(

        imageUrl: imageUrl,
        title: title,

    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl']=this.imageUrl;
    data['title']=this.title;



    return data;
  }
}