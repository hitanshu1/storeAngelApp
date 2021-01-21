class PaymentResponseModel{
  int statusCode;
  String message;
  String paymentId;
  PaymentResponseModel({this.message,this.statusCode,this.paymentId});
}