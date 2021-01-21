import 'package:storeangelApp/core/services/navigation_service.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/screens/consumer/allow_Location_Screen.dart';
import 'package:storeangelApp/ui/screens/consumer/tell_us_your_address_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class CheckingAcceptedEmail extends BaseModel
{
  final _navigationService = getIt<NavigationService>();

  void delayFunction()
  {
    Future.delayed(Duration(seconds: 2), () {
      _navigationService.navigateTo(TellUsYourAddressScreen.routeName).then((value){
        Future.delayed(Duration(seconds: 2), () {
          _navigationService.navigateReplaceTo(TellUsYourAddressScreen.routeName).then((value){
            delayFunction();
          });
        });
      });
    });
  }
}