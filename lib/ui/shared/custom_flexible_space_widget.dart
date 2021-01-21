import 'package:flutter/material.dart';
import 'package:storeangelApp/core/consts/appConstants.dart';

class CustomFlexibleSpaceWidget extends StatefulWidget {
  final ScrollController scrollController;
  final Widget child;

  CustomFlexibleSpaceWidget({this.scrollController, this.child});

  @override
  _CustomFlexibleSpaceWidgetState createState() => _CustomFlexibleSpaceWidgetState();
}

class _CustomFlexibleSpaceWidgetState extends State<CustomFlexibleSpaceWidget> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 0),
    );
    _animationController.forward();
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1).animate(_animationController);
    widget.scrollController.addListener(() {
      _fadeInFadeOut =
          Tween<double>(begin: 0, end: AppConstants.animationEndPoint(widget.scrollController.position.pixels.toInt()))
              .animate(_animationController);
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeInFadeOut,
      child: widget.child,
    );
  }
}
