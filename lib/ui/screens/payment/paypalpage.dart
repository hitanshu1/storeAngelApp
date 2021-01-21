import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/text_styles.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_paypal.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';
import 'package:storeangelApp/ui/shared/base_view.dart';
import 'package:storeangelApp/ui/shared/customAppBar.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PayPalPayment extends StatefulWidget {
  final Function onFinish;

  PayPalPayment({this.onFinish});

  @override
  State<StatefulWidget> createState() {
    return PayPalPaymentState();
  }
}

class PayPalPaymentState extends State<PayPalPayment> {



  @override
  Widget build(BuildContext context) {
    StatusBarService.changeStatusBarColor(StatusBarType.Dark, context);

    return BaseView<PayPalViewModel>(
      onModelReady: (model)=>model.initializeData(),
      builder: (context,model,child){
        if(model.state==ViewState.Busy){
          return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: AppConstants.circulerProgressIndicator());
        }
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: CustomAppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            leading:BackButton(
                  color: Theme.of(context).iconTheme.color,
              onPressed: (){
                model.navigatorPop();
              },
            ),
            title: Text(AppStrings.PAYPAL.tr(),
              style: AppStyles.BlackStyleWithBold800Font_24(context),),
          ),
          body: WebView(
            initialUrl: model.checkoutUrl,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) {
            return model.onNavigationDegree(request, widget.onFinish);
            },
          ),
        );
      },
    );
  }
}