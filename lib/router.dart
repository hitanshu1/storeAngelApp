import 'package:flutter/material.dart';
import 'package:storeangelApp/ui/screens/addnew_user_screen.dart';
import 'package:storeangelApp/ui/screens/complete_order_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/allow_Location_Screen.dart';
import 'package:storeangelApp/ui/screens/consumer/appIntroduction_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/checkingAcceptedEmail_Screen.dart';
import 'package:storeangelApp/ui/screens/consumer/courier_candidate_details_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/forgot_password_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/googleMapsFindAddress_Screen.dart';
import 'package:storeangelApp/ui/screens/consumer/intro_Screen.dart';
import 'package:storeangelApp/ui/screens/consumer/item_details_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/item_search_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/landing_Screen.dart';
import 'package:storeangelApp/ui/screens/consumer/login_Screen.dart';
import 'package:storeangelApp/ui/screens/consumer/mainApp_Screen.dart';
import 'package:storeangelApp/ui/screens/consumer/consumer_payment_method_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/order_details_and_chat_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/pick_Store_Screen.dart';
import 'package:storeangelApp/ui/screens/consumer/pick_new_store_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/save_articles_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/share_list/your_user_list_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/share_notification_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/signupDetails_Screen.dart';
import 'package:storeangelApp/ui/screens/consumer/signup_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/summery_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/tell_us_your_address_screen.dart';
import 'package:storeangelApp/ui/screens/consumer/userDecideTypeScreen.dart';
import 'package:storeangelApp/ui/screens/consumer/your_offer_screen.dart';
import 'package:storeangelApp/ui/screens/contract_conditions_screen.dart';
import 'package:storeangelApp/ui/screens/courier/courier_delivery_details_screen.dart';
import 'package:storeangelApp/ui/screens/courier/courier_item_details_screen.dart';
import 'package:storeangelApp/ui/screens/courier/courier_main_page.dart';
import 'package:storeangelApp/ui/screens/courier/courier_order/courier_order_delivered_summary_screen.dart';
import 'package:storeangelApp/ui/screens/courier/courier_order_delivered_screen.dart';
import 'package:storeangelApp/ui/screens/courier/courier_order_details_screen.dart';
import 'package:storeangelApp/ui/screens/courier/courier_order_summery_screen.dart';
import 'package:storeangelApp/ui/screens/courier/courier_orderproductDetailslist.dart';
import 'package:storeangelApp/ui/screens/courier/courier_signup_screen.dart';
import 'package:storeangelApp/ui/screens/courier/request_details_screen.dart';
import 'package:storeangelApp/ui/screens/courier/payment_method_screen.dart';
import 'package:storeangelApp/ui/screens/courier/signup_confirmation_screen.dart';
import 'package:storeangelApp/ui/screens/courier/tell_us_about_your_company_screen.dart';
import 'package:storeangelApp/ui/screens/courier_status_screen.dart';
import 'package:storeangelApp/ui/screens/deliverylocation_screen.dart';
import 'package:storeangelApp/ui/screens/order_courier_flow/estimation_screen.dart';
import 'package:storeangelApp/ui/screens/items/addItems_search_screen.dart';
import 'package:storeangelApp/ui/screens/items/alternativeProduct/find_alternative.dart';
import 'package:storeangelApp/ui/screens/items/alternativeProduct/single_alternative_product_view.dart';
import 'package:storeangelApp/ui/screens/items/common_item_details_screen.dart';
import 'package:storeangelApp/ui/screens/items/last_item_package_screen.dart';
import 'package:storeangelApp/ui/screens/list_users_screen.dart';
import 'package:storeangelApp/ui/screens/order/afterwards/order_afterward_payment_method_screen.dart';
import 'package:storeangelApp/ui/screens/order/afterwards/order_payment_afterwards_screen.dart';
import 'package:storeangelApp/ui/screens/order/check_out_page.dart';
import 'package:storeangelApp/ui/screens/order/created_list_screen.dart';
import 'package:storeangelApp/ui/screens/order/order_page.dart';
import 'package:storeangelApp/ui/screens/order/order_payment_method_screen.dart';
import 'package:storeangelApp/ui/screens/order/store_catalogue_screen.dart';
import 'package:storeangelApp/ui/screens/order_courier_flow/select_product_screen.dart';
import 'package:storeangelApp/ui/screens/order_delivered_screen.dart';
import 'package:storeangelApp/ui/screens/premiumScreen.dart';
import 'package:storeangelApp/ui/screens/premium_first_screen.dart';
import 'package:storeangelApp/ui/screens/proposal_screen.dart';
import 'package:storeangelApp/ui/screens/purchase_screen.dart';
import 'package:storeangelApp/ui/screens/receipt_screen.dart';
import 'package:storeangelApp/ui/screens/receipt_view_screen.dart';
import 'package:storeangelApp/ui/screens/stripe_verfication_webview.dart';
import 'package:storeangelApp/ui/screens/watchlist_detaillist_item_screen.dart';
import 'package:storeangelApp/ui/widgets/courier/single_offer_screen.dart';

import 'ui/screens/consumer/share_list/share_list_screen.dart';
import 'ui/screens/consumer/store_details_screen.dart';
const String initialRoute = LandingScreen.routeName;

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LandingScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => LandingScreen(argument: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case MainAppScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => MainAppScreen(index: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case SignUpScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => SignUpScreen(arguments: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case IntroScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => IntroScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case LoginScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginScreen(back: settings.arguments,),
          transitionDuration: Duration(seconds: 0),
        );
      case SignUpDetailsScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => SignUpDetailsScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case UserDecideTypeScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => UserDecideTypeScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case PremiumScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => PremiumScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case CheckingAcceptedEmailScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => CheckingAcceptedEmailScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case AllowLocationScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => AllowLocationScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case GoogleMapsFindAddressScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => GoogleMapsFindAddressScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case AppIntroductionScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => AppIntroductionScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case PickStoreScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => PickStoreScreen(arguments: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case PurchaseScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => PurchaseScreen(purchaseDetails: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case WatchListDetailListItemScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => WatchListDetailListItemScreen(argument: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );

      case AddItemSearchScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => AddItemSearchScreen(argument: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case ListUsersScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => ListUsersScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case AddNewUserScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => AddNewUserScreen(),
          transitionDuration: Duration(seconds: 0),
        );

      case StoreCatalogueScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => StoreCatalogueScreen(store: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case ListCreatedScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => ListCreatedScreen(purchaseDetails: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case EstimationScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => EstimationScreen(purchaseDetails: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case CourierCheckOutScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => CourierCheckOutScreen(argument: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case OrderPageScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => OrderPageScreen(purchaseDetails: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case OrderDeliveredScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => OrderDeliveredScreen(argument: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case FindAlternativeScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => FindAlternativeScreen(argument: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case CourierVerifyScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => CourierVerifyScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case SignUpConfirmationScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => SignUpConfirmationScreen(imageFile: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case PaymentMethodScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => PaymentMethodScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case CourierMainAppScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => CourierMainAppScreen(index: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );

      case RequestDetailsScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => RequestDetailsScreen(order: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );

      case CourierOrderDeliveredScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => CourierOrderDeliveredScreen(argument: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );

      case SingleAlternativeProductView.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => SingleAlternativeProductView(arguments: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case CourierOrderProductListScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => CourierOrderProductListScreen(argument: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case ProposalScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => ProposalScreen(argument: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case NewOrderSelectStore.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => NewOrderSelectStore(),
          transitionDuration: Duration(seconds: 0),
        );
      case ShareNotificationScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => ShareNotificationScreen(purchaseDetails: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case DeliveryLocationScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => DeliveryLocationScreen(purchaseDetails: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );

      case OrderPaymentMethodScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => OrderPaymentMethodScreen(argument: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case CourierStatusScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => CourierStatusScreen(argument: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case CommonItemsDetailsScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => CommonItemsDetailsScreen(argument: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case ForgotPasswordScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => ForgotPasswordScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case StripVerificationWebView.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => StripVerificationWebView(arguments: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case LastItemPackageScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => LastItemPackageScreen(),
          transitionDuration: Duration(seconds: 0),
        );

      case CompleteOrderScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => CompleteOrderScreen(orderOrPurchases: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case SingleOfferScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => SingleOfferScreen(order: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case CourierOrderDeliveredSummaryScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => CourierOrderDeliveredSummaryScreen(order: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case TellUsAboutYourCompanyScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => TellUsAboutYourCompanyScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case OrderPaymentAfterWardsScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => OrderPaymentAfterWardsScreen(order: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case OrderAfterWardPaymentMethodScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => OrderAfterWardPaymentMethodScreen(orderOrPurchases: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case SelectProductScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => SelectProductScreen(purchaseDetails: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );

      case ReceiptViewScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => ReceiptViewScreen(receipts: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case CourierOrderDetailsScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => CourierOrderDetailsScreen(order: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case CourierDeliveryDetailsScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => CourierDeliveryDetailsScreen(arguments: settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case YourOfferScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => YourOfferScreen(order: settings.arguments,),
          transitionDuration: Duration(seconds: 0),
        );
      case CourierCandidateDetailsScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => CourierCandidateDetailsScreen(arguments: settings.arguments,),
          transitionDuration: Duration(seconds: 0),
        );
      case SummeryScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => SummeryScreen(argument: settings.arguments,),
          transitionDuration: Duration(seconds: 0),
        );
      case ConsumerPaymentMethodScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => ConsumerPaymentMethodScreen(arguments: settings.arguments,),
          transitionDuration: Duration(seconds: 0),
        );
      case ConsumerPaymentMethodScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => ConsumerPaymentMethodScreen(arguments: settings.arguments,),
          transitionDuration: Duration(seconds: 0),
        );
      case OrderDetailsAndChatScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => OrderDetailsAndChatScreen(arguments: settings.arguments,),
          transitionDuration: Duration(seconds: 0),
        );
      case SaveArticlesScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => SaveArticlesScreen(purchaseDetails: settings.arguments,),
          transitionDuration: Duration(seconds: 0),
        );
      case ItemSearchScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => ItemSearchScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case ItemDetailsScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => ItemDetailsScreen(arguments: settings.arguments,),
          transitionDuration: Duration(seconds: 0),
        );
      case StoreDetailsScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => StoreDetailsScreen(initialIndex: settings.arguments,),
          transitionDuration: Duration(seconds: 0),
        );
      case ContractConditionsScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => ContractConditionsScreen(purchaseDetails: settings.arguments,),
          transitionDuration: Duration(seconds: 0),
        );

      case TellUsYourAddressScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => TellUsYourAddressScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case ShareListScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => ShareListScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case YourUserListScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => YourUserListScreen(selectedUser: settings.arguments,),
          transitionDuration: Duration(seconds: 0),
        );
      case PremiumFirstScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => PremiumFirstScreen(),
          transitionDuration: Duration(seconds: 0),
        );
      case CourierItemDetailsScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => CourierItemDetailsScreen(arguments: settings.arguments,),
          transitionDuration: Duration(seconds: 0),
        );
      case CourierOrderSummeryScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => CourierOrderSummeryScreen(arguments: settings.arguments,),
          transitionDuration: Duration(seconds: 0),
        );
      case ReceiptScreen.routeName:
        return  PageRouteBuilder(
          pageBuilder: (_, __, ___) => ReceiptScreen(participant: settings.arguments,),
          transitionDuration: Duration(seconds: 0),
        );


      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
