import 'package:storeangelApp/ui/shared/base_model.dart';

class CourierMainViewModel extends BaseModel{
  int _bottomNavigationIndex = 0;
  int get bottomNavigationIndex =>_bottomNavigationIndex;
  void setBottomNavigationIndex(int val){
    _bottomNavigationIndex = val;
    setState(ViewState.Busy);
  }

  void initializeData(int index){
    setState(ViewState.Busy);
    if(index!=null){
      _bottomNavigationIndex=index;
    }

    setState(ViewState.Idle);
  }

}