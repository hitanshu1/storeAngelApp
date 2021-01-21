import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/ui/shared/platform_widget.dart';

class PlatformAlertDialog extends PlatformWidget {
  PlatformAlertDialog({
    @required this.title,
    @required this.content,
    this.cancelActionText,
    this.defaultFunction,
    this.defaultFunction2,
    this.barrierDismissible:true,
    @required this.defaultActionText,
    this.defaultActionText2
  })  : assert(title != null),
        assert(content != null),
        assert(defaultActionText != null);

  final String title;
  final String content;
  final String cancelActionText;
  final String defaultActionText;
  final String defaultActionText2;
  final Function defaultFunction;
  final Function defaultFunction2;
  final bool barrierDismissible;

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context,
            barrierDismissible: barrierDismissible,
            builder: (context) => this,
          )
        : await showDialog<bool>(
            context: context,
            barrierDismissible: barrierDismissible,
            builder: (context) => this,
          );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyle(fontSize: SizeConfig.fontSizeLargest, color: Theme.of(context).focusColor),),
      content: Text(content, style: TextStyle(fontSize: SizeConfig.fontSizeLarge, color: Theme.of(context).focusColor),),
      backgroundColor: Theme.of(context).cardColor,
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final actions = <Widget>[];
    if (cancelActionText != null) {
      actions.add(
        PlatformAlertDialogAction(
          child: Text(cancelActionText),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      );
    }
    actions.add(
      PlatformAlertDialogAction(
        child: Text(defaultActionText),
        onPressed: () {
          if(defaultFunction!=null){
            return defaultFunction();
          }else{
            return Navigator.of(context).pop(true);
          }

          },
      ),
    );
    if(defaultActionText2!=null)actions.add(
      PlatformAlertDialogAction(
        child: Text(defaultActionText2),
        onPressed: (){
          if(defaultFunction2!=null){
            return defaultFunction2();

          }else{
           return  Navigator.of(context).pop(true);
          }

        },
      )
    );
    return actions;
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  PlatformAlertDialogAction({this.child, this.onPressed});
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }
}
