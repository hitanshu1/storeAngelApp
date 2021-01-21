import 'package:flutter/material.dart';
import 'package:storeangelApp/core/models/courier_candidate_model.dart';
import 'package:storeangelApp/core/models/response_model.dart';
import 'package:storeangelApp/core/services/firebase_abstraction.dart';
import 'package:storeangelApp/core/services/statusbar_service.dart';
import 'package:storeangelApp/ui/shared/MyUtils.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

import '../../getIt.dart';

class ViewCourierCandidateDetailsViewModel extends BaseModel{
  FirebaseAbstraction database=getIt<FirebaseAbstraction>();

  Future<void> navigateToScreen(String routeName,BuildContext context,{Object arguments}) async{
    await navigationService.navigateTo(routeName, arguments: arguments).then((value){
      StatusBarService.changeStatusBarColor(StatusBarType.White, context);
    });
  }

  void onToggleFav(CourierCandidate candidate)async{
    setState(ViewState.Busy);
    candidate.favourite=!candidate.favourite;
    ResponseModel responseModel=await database.onUpdateCandidate(candidate);
    MyUtils().toastsuccessdisplay(responseModel.message);

    setState(ViewState.Idle);
  }
}