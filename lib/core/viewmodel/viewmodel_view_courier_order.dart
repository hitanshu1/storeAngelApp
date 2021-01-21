
import 'package:storeangelApp/ui/shared/base_model.dart';

class ViewCourierOrderViewModel extends BaseModel{

  bool viewDetails=false;

  void toggleView(){
    setState(ViewState.Busy);
    viewDetails=!viewDetails;
    setState(ViewState.Idle);
  }

}