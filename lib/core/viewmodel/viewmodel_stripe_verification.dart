
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:storeangelApp/core/models/stripe_verify_account.dart';
import 'package:storeangelApp/core/services/base_api.dart';
import 'package:storeangelApp/core/services/strip_verification_service.dart';
import 'package:storeangelApp/ui/screens/courier/payment_method_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class StripeVerificationViewModel extends BaseModel{
  final flutterWebViewPlugin = new FlutterWebviewPlugin();
  StripVerificationService _api = getIt<StripVerificationService>();
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }

  void initializePlugIn(String accountId,){
    setState(ViewState.Busy);
    flutterWebViewPlugin.onUrlChanged.listen((String url) async{
      if (url=='https://example.com/return') {
        StripeVerifyAccount ac=await _api.getAccountDetails(accountId);
        if(ac.id==accountId){
          setState(ViewState.Idle);
          navigateToScreen(PaymentMethodScreen.routeName);

        }else{
          setState(ViewState.Idle);

        }

      }
    });
    setState(ViewState.Idle);
  }

}