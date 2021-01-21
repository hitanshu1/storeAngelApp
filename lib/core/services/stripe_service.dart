import 'package:storeangelApp/core/models/payment_responsemodel.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
// import 'package:stripe_payment/stripe_payment.dart';

class StripeService {

  static installStripe() {
    /*StripePayment.setOptions(
        StripeOptions(publishableKey: "pk_test_51HJc2FJuvB7YSQ3ZCosYCmAW58DFHF4e0C4VW37FaKoIWmf9nT8CArO0RNzC4XyxShw4EJflNgObQuGc58wRsbrn00AIqUCuVI",
            merchantId: "Test", androidPayMode: 'test',));*/
  }

  static Future<PaymentResponseModel> googleAndApplePay(amount){
   /* return StripePayment.paymentRequestWithNativePay(
      androidPayOptions: AndroidPayPaymentRequest(
        totalPrice: "$amount",
        currencyCode: "EUR",
      ),
      applePayOptions: ApplePayPaymentOptions(
        countryCode: 'DE',
        currencyCode: 'EUR',

        items: [
          ApplePayItem(
            label: 'Test',
            amount: '$amount',
          )
        ],
      ),
    ).then((token) {
      return PaymentResponseModel(
        statusCode: 1,paymentId: token.tokenId,
        message: 'Payment success'
      );
    }).catchError((e){
      return PaymentResponseModel(
        statusCode: 0,message: e.message
      );
    });*/
  }
  static Future<PaymentResponseModel> googlePay(amount){
    /*return StripePayment.paymentRequestWithNativePay(
      androidPayOptions: AndroidPayPaymentRequest(
        totalPrice: "$amount",
        currencyCode: "EUR",
      ),
      applePayOptions: ApplePayPaymentOptions(
        countryCode: 'DE',
        currencyCode: 'EUR',

        items: [
          ApplePayItem(
            label: 'Test',
            amount: '$amount',
          )
        ],
      ),
    ).then((token) {
      return PaymentResponseModel(
          statusCode: 1,paymentId: token.tokenId,
          message: 'Payment success'
      );
    }).catchError((e){
      return PaymentResponseModel(
          statusCode: 0,message: e.message
      );
    });*/
  }
  static void createPayment(amount){
   /* StripePayment.createSourceWithParams(SourceParams(
      type: 'ideal',
      amount: amount,
      currency: 'eur',
      returnURL: 'example://stripe-redirect',
    )).then((source) {

    }).catchError((e){
      MyUtils().toastdisplay(e.message);
    });*/
  }
  static void confirmPaymentIntent(){
    /*StripePayment.confirmPaymentIntent(
      PaymentIntent(
        clientSecret: 'pk_test_aSaULNS8cJU6Tvo20VAXy6rp',
        paymentMethodId: 'test',
      ),
    ).then((paymentIntent) {

    }).catchError((e){

    });*/
  }
  static void payWithCard(){
   /* StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest()).then((paymentMethod) {
     MyUtils().toastsuccessdisplay(paymentMethod.id);
    }).catchError((e){
      MyUtils().toastdisplay(e.message);
    });*/
  }
  static Future<PaymentResponseModel> paySofort(amount){
    /*return StripePayment.createSourceWithParams(SourceParams(
      type: 'sofort',
      amount: amount,
      currency: 'eur',
      country: 'AT',
      returnURL: 'example://stripe-redirect',
    )).then((source) {
      return PaymentResponseModel(message: 'Payment success',statusCode: 1,paymentId: source.sourceId);
    }).catchError((e){
      return PaymentResponseModel(statusCode: 0,message: e.message,);
    });*/
  }
  static Future<PaymentResponseModel>  amazonPay(amount){
    /*return StripePayment.createSourceWithParams(SourceParams(
      type: 'amazonpay',
      amount: amount,
      currency: 'eur',
      country: 'AT',
      returnURL: 'example://stripe-redirect',
    )).then((source) {
      return PaymentResponseModel(message: 'Payment success',statusCode: 1,paymentId: source.sourceId);
    }).catchError((e){
      return PaymentResponseModel(statusCode: 0,message: e.message,);
    });*/
  }
}