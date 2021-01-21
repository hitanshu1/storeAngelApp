import 'package:storeangelApp/core/services/paypal_service.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class PayPalViewModel extends BaseModel{

  String checkoutUrl;
  String executeUrl;
  String accessToken;
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic,dynamic> defaultCurrency = {"symbol": "USD ", "decimalDigits": 2, "symbolBeforeTheNumber": true, "currency": "USD"};

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL= 'cancel.example.com';
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }
  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": 'iPhone 11',
        "quantity": 1,
        "price": '1.99',
        "currency": defaultCurrency["currency"]
      }
    ];


    // checkout invoice details
    String totalAmount = '1.99';
    String subTotalAmount = '1.99';
    String shippingCost = '0';
    int shippingDiscountCost = 0;

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount":
              ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {
        "return_url": returnURL,
        "cancel_url": cancelURL
      }
    };
    return temp;
  }

  void initializeData()async{
    setState(ViewState.Busy);
    try {
      var  accessToken = await services.getAccessToken();

      final transactions = getOrderParams();
      final res =
      await services.createPaypalPayment(transactions, accessToken);
      if (res != null) {
        checkoutUrl = res["approvalUrl"];
        executeUrl = res["executeUrl"];
        setState(ViewState.Idle);
      }else{
        setState(ViewState.Idle);
      }
    } catch (e) {
      print('exception: '+e.toString());
      MyUtils().toastdisplay(e.toString());
    }setState(ViewState.Idle);
  }
  Future<NavigationDecision> onNavigationDegree(NavigationRequest request,Function onFinish)async{
    if (request.url.contains(returnURL)) {
      final uri = Uri.parse(request.url);
      final payerID = uri.queryParameters['PayerID'];
      if (payerID != null) {
        services
            .executePayment(executeUrl, payerID, accessToken)
            .then((id) {
          onFinish(id);
          navigationService.pop();
        });
      } else {
        navigationService.pop();
      }
      navigationService.pop();
    }
    if (request.url.contains(cancelURL)) {
      navigationService.pop();
    }
    return NavigationDecision.navigate;

  }
}