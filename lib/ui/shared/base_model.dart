// base_model.dart
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/services/navigation_service.dart';

import '../../getIt.dart';

class BaseModel extends ChangeNotifier {
  final navigationService = getIt<NavigationService>();
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}

// viewstate.dart/
// Represents the state of the view
enum ViewState { Idle, Busy }