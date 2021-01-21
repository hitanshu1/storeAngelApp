import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_facebooklogin.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import '../customAppBar.dart';

class FaceBookLogInWebView extends StatefulWidget {
  final String selectedUrl;

  FaceBookLogInWebView({this.selectedUrl});

  @override
  _FaceBookLogInWebViewState createState() => _FaceBookLogInWebViewState();
}

class _FaceBookLogInWebViewState extends State<FaceBookLogInWebView> {

  @override
  Widget build(BuildContext context) {
    return BaseView<FaceBookLoginViewModel>(
      onModelReady: (model)=>model.initializePlugIn(),
      builder: (context,model,child){
        if(model.state==ViewState.Busy){
          return AppConstants.circulerProgressIndicator();
        }
        return WebviewScaffold(
            url: widget.selectedUrl,
            appBar: new CustomAppBar(
              backgroundColor: Color.fromRGBO(66, 103, 178, 1),
              title: new Text("Facebook login"),
            ));
      },
    );
  }
}