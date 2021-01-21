
import 'package:storeangelApp/core/services/sharedPreference.dart';
import 'package:storeangelApp/ui/screens/consumer/appIntroduction_screen.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';

class IntroViewModel extends BaseModel {

  void navigateToScreen() {
    getIt<AppSharedPreferences>().setBool(AppSharedPreferences.isAlreadyString, true);
    navigationService.navigateTo(AppIntroductionScreen.routeName);
  }
}
