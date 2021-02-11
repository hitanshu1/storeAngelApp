import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/models/app_initiale_value.dart';
import 'package:storeangelApp/core/models/germanLookupMessages.dart';
import 'package:storeangelApp/core/services/navigation_service.dart';
import 'package:storeangelApp/core/services/sharedPreference.dart';
import 'package:storeangelApp/core/services/stripe_service.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/common_itemsscreen_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_additems.dart';
import 'package:storeangelApp/core/viewmodel/viewmodel_profile.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/router.dart';

import 'package:storeangelApp/ui/screens/consumer/landing_Screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'core/models/user.dart';
import 'core/services/auth_service.dart';
import 'core/viewmodel/googleMapsFindAddress_viewModel.dart';
import 'core/viewmodel/selectAddress_viewmodel.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();

  await StripeService.installStripe();
  timeago.setLocaleMessages('de', GermanLookUpMessages());

  setupLocator();

  //Change/Add Strings in the assets/translation/... files
  final initialValue = await getIt<AppSharedPreferences>().getAppInitialValues();

  Future.delayed(Duration(seconds: 2),(){
    FlutterStatusbarManager.setHidden(false);
  });

  runApp(
    EasyLocalization(
        supportedLocales: [
          Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
          Locale.fromSubtags(languageCode: 'de')
        ],
        path: 'assets/translations', // <-- change patch to your
        fallbackLocale: Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
        child: MyApp(
          appTheme: initialValue.darkMode ? AppTheme.dark : AppTheme.light,
          isAlready: initialValue.isAlready,
          appInitialValue: initialValue,
        )),
  );
}

class MyApp extends StatelessWidget {
  final ThemeData appTheme;
  final bool isAlready;
  final AppInitialValue appInitialValue;

  MyApp({this.appTheme, this.isAlready, this.appInitialValue});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getIt<GoogleMapsFindAddressModel>()),
        ChangeNotifierProvider.value(value: getIt<SelectAddressViewModel>()),
        ChangeNotifierProvider(create: (context) => AddItemsViewModel()),
        ChangeNotifierProvider(
          create: (context) => getIt<ProfileViewModel>(),
        ),
        ChangeNotifierProvider(
          create: (context) => CommonItemScreenViewModel(),
        ),
        StreamProvider<UserModel>.value(
          value: Auth().onAuthStateChanged,
        ),
        ChangeNotifierProvider.value(value: AppThemeViewModel(appTheme, appInitialValue)),
        Provider<AuthBase>(
          create: (context) => Auth(),)

      ],
      child: AppMainMaterialApp(
        isAlready: isAlready,
      ),
    );
  }
}

class AppMainMaterialApp extends StatelessWidget {
  final bool isAlready;

  AppMainMaterialApp({this.isAlready});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppThemeViewModel>(context);

    return MaterialApp(
      title: 'StoreAngel',
      theme: theme.themeData,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      navigatorKey: getIt<NavigationService>().navigatorKey,
      onGenerateRoute: AppRouter.generateRoute,
      home: LandingScreen(
        argument: LandingScreenArgument(isAlready: isAlready),
      ),
//    home: PickStoreScreen(),
//    home: CheckingAcceptedEmailScreen(),
    );
  }
}
