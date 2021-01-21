import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_stripe_verification.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';


class StripVerificationWebViewArguments{
  String accountId;
  String url;
  StripVerificationWebViewArguments({this.url,this.accountId});
}
class StripVerificationWebView extends StatefulWidget {
  static const String routeName = 'stripVerificationWebView';
  final StripVerificationWebViewArguments arguments;
  StripVerificationWebView({this.arguments});

  @override
  _StripVerificationWebViewState createState() => _StripVerificationWebViewState();
}

class _StripVerificationWebViewState extends State<StripVerificationWebView> {




  @override
  Widget build(BuildContext context) {
    return BaseView<StripeVerificationViewModel>(
      onModelReady: (model)=>model.initializePlugIn(widget.arguments.accountId),
      builder: (context,model,child){
        if(model.state==ViewState.Busy){
          return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: AppConstants.circulerProgressIndicator());
        }
        return WebviewScaffold(
          initialChild: AppConstants.circulerProgressIndicator(),
            url:  widget.arguments.url,
        );
      },
    );

  }
}
