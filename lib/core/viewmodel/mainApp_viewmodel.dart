

import 'package:storeangelApp/ui/shared/base_model.dart';

class MainAppViewModel extends BaseModel {
  int _bottomNavigationIndex = 0;
  int get bottomNavigationIndex =>_bottomNavigationIndex;
  void setBottomNavigationIndex(int val){
    _bottomNavigationIndex = val;
    setState(ViewState.Busy);
  }

  void initializeData(value){
    _bottomNavigationIndex=value;
    setState(ViewState.Idle);
  }


}