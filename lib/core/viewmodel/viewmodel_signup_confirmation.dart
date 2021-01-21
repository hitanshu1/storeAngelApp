import 'package:storeangelApp/core/services/strip_verification_service.dart';
import 'package:storeangelApp/ui/screens/stripe_verfication_webview.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';

class SignUpConfirmationViewModel extends BaseModel{
  StripVerificationService _api = getIt<StripVerificationService>();
  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }

  void onStart()async{
    setState(ViewState.Busy);
    try{
      _api.createAccount().then((accountId){
        print('$accountId');
        _api.getAccountLink(accountId).then((value)async{
          if(value!=null){
            setState(ViewState.Idle);
            navigateToScreen(StripVerificationWebView.routeName,arguments: StripVerificationWebViewArguments(
                url: value,accountId: accountId
            ));
          }else{
            setState(ViewState.Idle);
          }
        });
      });
    }catch(e){

      setState(ViewState.Idle);
    }

  }
}