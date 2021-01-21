import 'dart:ui';

import 'package:flutter/material.dart';

class ShowBottomSheet{


  static void showLarge({BuildContext context,Widget child,double heightFactor}){
    Future<void> future=showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc){
          return FractionallySizedBox(
            heightFactor: heightFactor!=null?heightFactor:.9,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 1),
              child:child)
          );
        }
    );
    future.then((value) {

    });
  }

}