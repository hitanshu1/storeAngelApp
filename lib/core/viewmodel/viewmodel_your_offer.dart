
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class YourOfferViewModel extends BaseModel{

  void onToggleFave(bool val,CourierCandidate candidate){

  }

  void navigatorPop() {
    navigationService.pop();
  }
  void navigateToScreen(String routeName,{Object arguments}) {
    navigationService.navigateTo(routeName, arguments: arguments);
  }
}