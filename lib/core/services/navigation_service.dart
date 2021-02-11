import 'package:flutter/material.dart';

class NavigationService{

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  Future navigateTo(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushNamed(routeName,arguments:arguments);
  }
  Future navigateReplaceTo(String routeName, {Object arguments}) {
    return navigatorKey.currentState.pushReplacementNamed(routeName,arguments:arguments);
  }
  
  Future pushNamedAndRemoveUntil(String routeName, {Object arguments}){
    return navigatorKey.currentState.pushNamedAndRemoveUntil(routeName, (route) => false);
  }


  bool pop({String routeName, Object argument}) {
    navigatorKey.currentState.pop(argument,);

    return true;
  }

}