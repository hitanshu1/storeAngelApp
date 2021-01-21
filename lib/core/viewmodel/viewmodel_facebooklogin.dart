import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class FaceBookLoginViewModel extends BaseModel{

  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }
  denied() {
    navigationService.pop();
  }

  succeed(String url) {
    var params = url.split("access_token=");

    var endParam = params[1].split("&");
    print(endParam[0]);

    navigationService.pop(argument: endParam[0]);
  }

  void initializePlugIn(){
    setState(ViewState.Busy);
    flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (url.contains("#access_token")) {
        succeed(url);
      }

      if (url.contains(
          "https://www.facebook.com/connect/login_success.html?error=access_denied&error_code=200&error_description=Permissions+error&error_reason=user_denied")) {
        denied();
      }
    });
    setState(ViewState.Idle);
  }
}