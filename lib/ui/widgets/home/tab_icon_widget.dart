import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget{
  const CustomIcon(this.name, { Key key, this.size, this.color, }) : super(key: key);

  final String name;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {

    final IconThemeData iconTheme = IconTheme.of(context);
    final double iconOpacity = iconTheme.opacity;
    Color iconColor = color ?? iconTheme.color;

    if (iconOpacity != 1.0) iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);
    return Image.asset(name, color: iconColor, height: size,);
  }
}