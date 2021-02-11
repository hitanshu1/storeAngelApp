

import 'package:get_it/get_it.dart';
import 'package:storeangelApp/core/services/auth_service.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/firebase_service_impl.dart';
import 'package:storeangelApp/core/services/navigation_service.dart';
import 'package:storeangelApp/core/services/sharedPreference.dart';
import 'package:storeangelApp/core/services/strip_verification_service.dart';
import 'package:storeangelApp/core/viewmodel/common_itemsscreen_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/courier_chat_tab_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/courier_details_tab_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_chat_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_delivered_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_details_tabone_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/courier_order_details_two_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/deliverylocation_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/forgot_password_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/googleMapsFindAddress_viewModel.dart';
import 'package:storeangelApp/core/viewmodel/home_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/insurance_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/intro_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/login_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/mainApp_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/myaddress_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/payment_option_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/photo_porvider.dart';
import 'package:storeangelApp/core/viewmodel/premiumViewModel.dart';
import 'package:storeangelApp/core/viewmodel/purchase_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/selectAddress_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/signupDetails_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/signup_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/starting_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/userDecideType_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/view_model_checkout.dart';
import 'package:storeangelApp/core/viewmodel/view_model_order_information.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_additems.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_additems_search.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_addnewuser.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_available_bar.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_business_information.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_chat_message_list_widget.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_complete_order_screen.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_consumer_payment_method.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_candidate_details.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_current_order_tab.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_current_status_widget.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_mainpage.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_offers.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order_deleivered_summary.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order_details.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_order_productlist.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_signup_screen.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_status.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_current_order_screen.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_estimation.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_facebooklogin.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_find_alternative.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_courier_request.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_item_details.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_item_search.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_last_item_package.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_listuser.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_mystore.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_notifications.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_order_afterward_payment_method.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_order_delivery.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_order_details_and_chat.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_order_payment_method.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_orderpage.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_payment_afterwards.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_payment_methode_screen.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_paypal.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_persional_information.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_proposal_submitted.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_proposalcongratulation.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_ratingdialog.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_readytowork.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_receipt_view.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_save_articles.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_select_product.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_selectable_item_list.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_setting.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_signup_confirmation.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_store_catalogue.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_store_details.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_stripe_verification.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_summary_screen.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_tell_us_about_your_company.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_view_courier_order.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_viewcourier_candidate_details.dart';

import 'core/viewmodel/allowLocation_viewmodel.dart';
import 'core/viewmodel/appIntroduction_viewmodel.dart';
import 'core/viewmodel/checkingAcceptedEmail_viewmodel.dart';
import 'core/viewmodel/contact_And_Help_viewmodel.dart';
import 'core/viewmodel/pickStore_viewmodel.dart';
import 'core/viewmodel/premium_first_screen_viewmodel.dart';
import 'core/viewmodel/view_model_client_details_tile.dart';
import 'core/viewmodel/view_model_courier_delivery_details.dart';
import 'core/viewmodel/view_model_courier_item_details.dart';
import 'core/viewmodel/view_model_courier_order_summery.dart';
import 'core/viewmodel/view_model_pick_new_store.dart';
import 'core/viewmodel/viewmodel_contract_condition_viewmodel.dart';
import 'core/viewmodel/viewmodel_share_list.dart';
import 'core/viewmodel/viewmodel_single_alternative_product.dart';
import 'core/viewmodel/viewmodel_tell_us_your_address.dart';
import 'core/viewmodel/viewmodel_watchlist.dart';
import 'core/viewmodel/viewmodel_watchlist_detail.dart';
import 'core/viewmodel/viewmodel_your_offer.dart';



GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerFactory(() => Auth());
  //UI Models
  getIt.registerFactory(() => LogInViewModel());
  getIt.registerFactory(() => SignUpViewModel());
  getIt.registerLazySingleton(() => SignUpDetailsViewModel());
  getIt.registerFactory(() => HomeViewModel());
  getIt.registerFactory(() => AllowLocationViewModel());
  getIt.registerFactory(() => SelectAddressViewModel());
  getIt.registerFactory(() => PickStoreViewModel());
  getIt.registerFactory(() => UserDecideTypeViewModel());
  getIt.registerFactory(() => IntroViewModel());
  getIt.registerFactory(() => CheckingAcceptedEmail());
  getIt.registerFactory(() => AppIntroductionViewModel());
  getIt.registerFactory(() => StartingViewModel());
  getIt.registerFactory(() => GoogleMapsFindAddressModel());
  getIt.registerFactory(() => MainAppViewModel());
  getIt.registerFactory(() => PurchaseViewModel());
  getIt.registerFactory(() => MyAddressViewModel());

  //Services
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerLazySingleton<FirebaseAbstraction>(() => MyFirebaseServiceImpl());
  getIt.registerLazySingleton(() => MyFirebaseServiceImpl());
  getIt.registerLazySingleton(() => AppSharedPreferences());

  getIt.registerFactory(() => WatchListViewModel());
  getIt.registerFactory(() => WatchListDetailViewModel());


  getIt.registerFactory(() => AddItemsViewModel());
  getIt.registerFactory(() => MyStoreViewModel());
  getIt.registerLazySingleton(() => ProfileViewModel());
  getIt.registerFactory(() => PersonalInformationViewModel());
  getIt.registerFactory(() => SettingViewModel());
  getIt.registerFactory(() => NotificationViewModel());


  getIt.registerFactory(() => ListUserViewModel());
  getIt.registerFactory(() => AddNewUserViewModel());

  getIt.registerFactory(() => CheckOutViewModel());
  getIt.registerFactory(() => OrderPageViewModel());
  getIt.registerFactory(() => FindAlternativeViewModel());
  getIt.registerFactory(() => CourierSignUpViewModel());
  getIt.registerFactory(() => PaymentMethodScreenViewModel());
  getIt.registerFactory(() => CourierRequestViewModel());
  getIt.registerFactory(() => CourierMainViewModel());
  getIt.registerFactory(() => ProposalCongratulationViewModel());
  getIt.registerFactory(() => ReadyToWorkViewModel());
  getIt.registerFactory(() => CurrentOrderViewModel());
  getIt.registerFactory(() => InsuranceViewModel());
  getIt.registerFactory(() => DeliveryLocationViewModel());
  getIt.registerFactory(() => OrderPaymentMethodViewModel());
  getIt.registerFactory(() => CourierStatusViewModel());

  getIt.registerFactory(() => CommonItemScreenViewModel());
  getIt.registerFactory(() => ForgotPasswordViewModel());

  getIt.registerFactory(() => PhotoProvider());
  getIt.registerFactory(() => StripVerificationService());
  getIt.registerFactory(() => StripeVerificationViewModel());
  getIt.registerFactory(() => CourierOrderDeliveredViewModel());
  getIt.registerFactory(() => CourierOrderProductListViewModel());
  getIt.registerFactory(() => OrderInformationViewModel());
  getIt.registerFactory(() => SignUpConfirmationViewModel());
  getIt.registerFactory(() => SingleAlterNativeProductViewModel());
  getIt.registerFactory(() => StoreCatalogueViewModel());
  getIt.registerFactory(() => PayPalViewModel());
  getIt.registerFactory(() => StoreDetailsViewModel());
  getIt.registerFactory(() => EstimationViewModel());
  getIt.registerFactory(() => ProposalSubmittedViewModel());
  getIt.registerFactory(() => FaceBookLoginViewModel());
  getIt.registerFactory(() => AvailableBarViewModel());
  getIt.registerFactory(() => LastItemPackageViewModel());
  getIt.registerFactory(() => AddItemsSearchViewModel());
  getIt.registerFactory(() => SelectableItemViewModel());
  getIt.registerFactory(() => ItemDetailsViewModel());
  getIt.registerFactory(() => CompleteOrderViewModel());
  getIt.registerFactory(() => OrderDeliveryViewModel());
  getIt.registerFactory(() => ViewCourierCandidateDetailsViewModel());
  getIt.registerFactory(() => RatingDialogViewModel());
  getIt.registerFactory(() => ViewCourierOrderViewModel());
  getIt.registerFactory(() => CourierOffersViewModel());
  getIt.registerFactory(() => CourierOrderViewModel());
  getIt.registerFactory(() => CourierCurrentStatusViewModel());
  getIt.registerFactory(() => CourierCurrentOrderTabViewModel());
  getIt.registerFactory(() => CourierOrderDeliveredSummaryViewModel());
  getIt.registerFactory(() => CourierChatTabViewModel());
  getIt.registerFactory(() => CourierDetailsTabViewModel());
  getIt.registerFactory(() => TellUsAboutYourCompanyViewModel());
  getIt.registerFactory(() => BusinessInformationViewModel());
  getIt.registerFactory(() => OrderPaymentAfterWardViewModel());
  getIt.registerFactory(() => OrderAfterWardPaymentMethodViewMoel());
  getIt.registerFactory(() => ChatMessageListViewModel());
  getIt.registerFactory(() => PremiumViewModel());
  getIt.registerFactory(() => ContactAndHelpViewModel());
  getIt.registerFactory(() => SelectProductViewModel());
  getIt.registerFactory(() => ReceiptViewModel());
  getIt.registerFactory(() => PaymentOptionViewModel());
  getIt.registerFactory(() => CourierOrderDetailsViewModel());
  getIt.registerFactory(() => CourierOrderChatViewModel());
  getIt.registerFactory(() => CourierOrderDetailsTabOneViewModel());
  getIt.registerFactory(() => CourierOrderDetailsTwoViewModel());
  getIt.registerFactory(() => YourOfferViewModel());
  getIt.registerFactory(() => CourierCandidateDetailsViewModel());
  getIt.registerFactory(() => SummaryViewModel());
  getIt.registerFactory(() => ConsumerPaymentMethodViewModel());
  getIt.registerFactory(() => OrderDetailsAndChatViewModel());
  getIt.registerFactory(() => SaveArticlesViewModel());
  getIt.registerFactory(() => ItemSearchViewModel());
  getIt.registerFactory(() => ContractConditionViewModel());
  getIt.registerFactory(() => TellUsYourAddressViewModel());
  getIt.registerFactory(() => ShareListViewModel());
  getIt.registerFactory(() => PickNewStoreViewModel());
  getIt.registerFactory(() => PremiumFirstScreenViewModel());
  getIt.registerFactory(() => ClientDetailsTileViewModel());
  getIt.registerFactory(() => CourierItemDetailsViewModel());
  getIt.registerFactory(() => CourierDeliveryDetailsViewModel());
  getIt.registerFactory(() => CourierOrderSummeryViewModel());
}