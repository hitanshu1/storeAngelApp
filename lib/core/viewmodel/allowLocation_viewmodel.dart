import 'package:storeangelApp/ui/shared/base_model.dart';

class AllowLocationViewModel extends BaseModel {
  void navigateToScreen(String routeName) {
    navigationService.navigateReplaceTo(routeName);
  }
}
