import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appColors.dart';

class UintListConverterService{

  static Future<Uint8List> getUintListFromIcon({IconData iconData,int height})async{
    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final iconStr = String.fromCharCode(iconData.codePoint);
    textPainter.text = TextSpan(
        text: iconStr,
        style: TextStyle(
          letterSpacing: 0.0,
          fontSize: height.toDouble()??100.0,
          fontFamily: iconData.fontFamily,
          color: AppColors.primaryColor,
        )
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(0.0, 0.0));
    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(height??100, height??100);
    final bytes = await image.toByteData(format: ImageByteFormat.png);

    return bytes.buffer.asUint8List();

  }
}