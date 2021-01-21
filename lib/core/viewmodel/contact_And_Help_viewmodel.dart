

import 'package:flutter/material.dart';
import 'package:storeangelApp/ui/shared/base_model.dart';

class ContactAndHelpViewModel extends BaseModel{
  bool hasShadow = false;
  ScrollController scrollController;


  void initialize(ScrollController scrollController){
    Future.delayed(Duration.zero,(){
      this.scrollController = scrollController;
      this.scrollController.addListener(addScrollListener);
    });
  }

  void addScrollListener(){
    if(scrollController.position.pixels==0){
      hasShadow = false;
    }else{
      hasShadow = true;
    }
    setState(ViewState.Idle);
  }


}