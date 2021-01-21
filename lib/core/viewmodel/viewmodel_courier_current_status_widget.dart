
import 'package:storeangelApp/ui/shared/base_model.dart';

class CourierCurrentStatusViewModel extends BaseModel{

  bool expanded=true;

  void toggleExpansion(){
    setState(ViewState.Busy);
    expanded=!expanded;
    setState(ViewState.Idle);
  }
}