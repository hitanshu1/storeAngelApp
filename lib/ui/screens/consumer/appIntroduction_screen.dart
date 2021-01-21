import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/consts/assetsPath.dart';
import 'package:storeangelApp/core/consts/sizeConfig.dart';
import 'package:storeangelApp/core/viewmodel/appIntroduction_viewmodel.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/ui/shared/button_widget.dart';
import 'package:storeangelApp/ui/widgets/appIntroduction/appIntroductionPagerItem.dart';

import '../../../getIt.dart';

class AppIntroductionScreen extends StatelessWidget {
  static const String routeName = 'appIntroductionScreen';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: getIt<AppIntroductionViewModel>(),
        child: AppIntroductionView());
  }
}


class AppIntroductionView extends StatefulWidget {

  @override
  _AppIntroductionViewState createState() => _AppIntroductionViewState();
}

class _AppIntroductionViewState extends State<AppIntroductionView> {
  final PageController _controller = PageController();

  ///Height depends on the height of the image and the height of the sizeBox placeholder within the PagerOnBoardWidget
  final double _topHeight = SizeConfig.screenHeight*.64;

  final List<Widget> _introductionPages_light_mode = [
    AppIntroductionPagerItem(
      AssetsPath.illustrations_2,
      AppStrings.ILLUSTRATION_ONE_HEADER.tr(),
      AppStrings.ILLUSTRATION_ONE_DESCRIPTION.tr(),
      position: 0,
    ),
    AppIntroductionPagerItem(
      AssetsPath.illustrations_3,
      AppStrings.ILLUSTRATION_TWO_HEADER.tr(),
      AppStrings.ILLUSTRATION_TWO_DESCRIPTION.tr(),
      position: 1,
      hasLargeGradient: false,
    ),
    AppIntroductionPagerItem(
      AssetsPath.illustrations_4,
      AppStrings.ILLUSTRATION_THREE_HEADER.tr(),
      AppStrings.ILLUSTRATION_THREE_DESCRIPTION.tr(),
      position: 2,
    ),
    AppIntroductionPagerItem(
      AssetsPath.illustrations_5n6,
      AppStrings.ILLUSTRATION_FOUR_HEADER.tr(),
      AppStrings.ILLUSTRATION_FOUR_DESCRIPTION.tr(),
      position: 3,
    )
  ];

  final List<Widget> _introductionPages_dark_mode = [
    AppIntroductionPagerItem(
      AssetsPath.illustrations_2_dark,
      AppStrings.ILLUSTRATION_ONE_HEADER.tr(),
      AppStrings.ILLUSTRATION_ONE_DESCRIPTION.tr(),
      position: 0,
    ),
    AppIntroductionPagerItem(
      AssetsPath.illustrations_3_dark,
      AppStrings.ILLUSTRATION_TWO_HEADER.tr(),
      AppStrings.ILLUSTRATION_TWO_DESCRIPTION.tr(),
      position: 1,
      hasLargeGradient: false,
    ),
    AppIntroductionPagerItem(
      AssetsPath.illustrations_4_dark,
      AppStrings.ILLUSTRATION_THREE_HEADER.tr(),
      AppStrings.ILLUSTRATION_THREE_DESCRIPTION.tr(),
      position: 2,
    ),
    AppIntroductionPagerItem(
      AssetsPath.illustrations_5n6_dark,
      AppStrings.ILLUSTRATION_FOUR_HEADER.tr(),
      AppStrings.ILLUSTRATION_FOUR_DESCRIPTION.tr(),
      position: 3,
    )
  ];

  
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
    });
  }
  
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeViewModel>(
      builder:(context, appThemeViewModel, child){
        bool isThemeLight = appThemeViewModel.themeData==AppTheme.light;
        return Scaffold(
          body: SizedBox(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: SafeArea(
              top: false,
              left: false,
              right: false,
              bottom: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 9,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: PageView.builder(
                            itemCount: isThemeLight?_introductionPages_light_mode.length:_introductionPages_dark_mode.length,
                            controller: _controller,
                            itemBuilder: (BuildContext context, int index) =>
                            isThemeLight?_introductionPages_light_mode[index]:_introductionPages_dark_mode[index],
                          ),
                        ),
                        Positioned(
                          top: _topHeight-SizeConfig.screenHeight*.03,
                          left: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: SmoothPageIndicator(
                              controller: _controller,
                              count: _introductionPages_light_mode.length,
                              effect: SwapEffect(
                                  dotHeight: 12,
                                  dotWidth: 12,
                                  dotColor: Theme.of(context).primaryColorLight,
                                  activeDotColor: Theme.of(context).primaryColor
                              ),
                            ),
                          ),

                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.09,
                          right: SizeConfig.screenWidth * 0.09,),
                      child: Column(
                        children: <Widget>[
                          Selector<AppIntroductionViewModel, String>(
                            selector: (context, model)=>model.buttonText,
                            builder: (context, buttonText, child) =>
                                ButtonWidget(
                              buttonText: AppStrings.NEXT.tr(),
                              radius: SizeConfig.introGetStarted_button_Radius,
                              fontSize: SizeConfig.fontSizeMedium,
                              buttonColor: Theme.of(context).primaryColor,
                              onPressed: (){
                                if(_controller.page>=_introductionPages_light_mode.length-1.5){
                                  Provider.of<AppIntroductionViewModel>(context, listen: false).navigateToScreen();
                                }else{
                                  _controller.animateToPage(_controller.page.toInt()+1,duration: Duration(milliseconds: 300), curve:  Curves.linear);
                                }

                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  SizeConfig.verticalSpaceMedium()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
