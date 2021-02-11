import 'package:flutter/material.dart';

class CustomFloatingActionButtonExtended extends StatelessWidget {
  final Widget label;

  const CustomFloatingActionButtonExtended({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: (){

      },
      heroTag: UniqueKey(),
      backgroundColor: Colors.transparent,
      focusColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      elevation: 0,
      label: label,
    );
  }
}
