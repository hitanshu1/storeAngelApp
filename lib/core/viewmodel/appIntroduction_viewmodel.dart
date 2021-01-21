import 'package:easy_localization/easy_localization.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/services/navigation_service.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/screens/consumer/userDecideTypeScreen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class AppIntroductionViewModel extends BaseModel {
  final _navigationService = getIt<NavigationService>();

  void navigateToScreen() {
    _navigationService.navigateTo(UserDecideTypeScreen.routeName);
  }

  String _buttonText = AppStrings.NEXT.tr();
  String get buttonText => _buttonText;
  void setButtonText(val){
    _buttonText = val;
    setState(ViewState.Busy);
  }


}
