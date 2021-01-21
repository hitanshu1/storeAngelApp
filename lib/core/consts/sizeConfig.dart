//size of the screen height, width, horizontal and vertical margins aso

//size of the screen height, width, horizontal and vertical margins aso

import 'package:flutter/cupertino.dart';
import 'package:storeangelApp/core/enums/mobileSize.dart';

class SizeConfig {
  static double screenWidth;
  static double screenHeight;
  static double appBarHeight;

  //font size
  static MobileSize mobileSize;
  static double mobileSizeScaleFactorVertical = 1.0;
  static double mobileSizeScaleFactorHorizontal = 1.0;
  static double fontSizeLargeExtraLarge;
  static const double fontSizeMedium = 14;
  static const double expandedHeight=170;
  static  double headerHeight;
  static  double customerHeaderHeight;
  static double smallHeaderSize;

  static double fontSizeVerySmall;
  static final  double fontSizeSmall = 12;
  static final  double fontSizeSmaller = 10;
  static double fontSizeLarge;
  static double fontSizeLarger;
  static double fontSizeLargeVeryLarge;
  static double forntSize20;
  static double fontSizeSmallVeryMedium;
  static double fontSizeLargest;
  static double fontSizeLargestBig;
  static double cameraContainerSize;
  static double fileImageContainerSize;

  //radius
  static double introGetStarted_button_Radius;
  static double radiusSmall;
  static double radiusSmaller;
  static double radiusBig;
  static double borderRadius=20;
  static double smallBorderRadius=15;

  //icon size
  static double iconSize;
  static double tabIconSize;
  static double smallIconSize;
  static double mediumIconSize;
  static double smallerIconSize;

  //distance from views to screenBorder
  static double horizontalGap;
  static double appBarIconSize;
  static double verticalGap;
  static double textFieldHeight=55;
  static double mediumIcon=30;
  static double largeIcon=40;
  static double serachAppbarheight=70;
  static double commonSliverAppBarBorderRadius=35;
  static double buttonHeight;
  static double tileHeight;
  static double _topPadding;


  static sizeConfigInit(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    _topPadding=MediaQuery.of(context).padding.top;
    int orgScreenWidth = screenWidth.round();
    int orgScreenHeight = screenHeight.round();

    appBarHeight=screenHeight*.13;

    fontSizeLargeExtraLarge = 28;
    cameraContainerSize=350;
    fileImageContainerSize=390;
    fontSizeVerySmall = 8;
    fontSizeSmallVeryMedium = 12;
    fontSizeLarge = 16;
    fontSizeLarger = 18;
    fontSizeLargeVeryLarge = 24;
    forntSize20=20;
    fontSizeLargest=orgScreenHeight*.03;
    fontSizeLargestBig = 28;
    smallIconSize=15;
    smallerIconSize=12;
    mediumIconSize=25;
    tileHeight=orgScreenHeight*.17;
    customerHeaderHeight=orgScreenHeight*.23;
    smallHeaderSize=orgScreenHeight*.19;
    headerHeight=orgScreenHeight*.25;


    //radius
    introGetStarted_button_Radius = orgScreenHeight * 0.02;
    radiusSmall = orgScreenHeight * 0.01;
    radiusSmaller=orgScreenHeight*.007;
    radiusBig = orgScreenHeight * 0.03;
    iconSize = orgScreenWidth * 0.05;
    tabIconSize = orgScreenHeight * 0.03;
    double mediumIcon=orgScreenWidth * 0.1;

    horizontalGap = SizeConfig.screenWidth*.09;
    appBarIconSize = 24;
    verticalGap=SizeConfig.screenHeight*.015;
    setMobileSize(screenHeight.toInt(), screenWidth.toInt());
    if(mobileSize==MobileSize.small){
      textFieldHeight = 45;
      buttonHeight=SizeConfig.screenHeight*.07;
    }else{
      textFieldHeight = SizeConfig.screenHeight*.08;
      buttonHeight=50;
    }

    /*
    print('width: $screenWidth');
    print('height: $screenHeight');
    print('mobile Scale: $mobileSizeScaleFactorVertical');*/
  }

  //Adaptive sizes according to the screenSizes
  static double radiusOfSliverAppbar=screenHeight*.05;
  static double textFieldAdaptiveHeight (double height) => height*(mobileSize==MobileSize.small?mobileSizeScaleFactorVertical-0.15:1);
  static double adaptiveHeight(double height)=>height*mobileSizeScaleFactorVertical;
  static double adaptiveWidth(double width)=>width*mobileSizeScaleFactorHorizontal;
  static adaptiveVerticalSpace(double height)=>verticalSpace(adaptiveHeight(height));
  static adaptiveHorizontalSpace(double width)=>horizontalSpace(adaptiveWidth(width));

  // Vertical spacing constants. Adjust to your liking.
  static double orderScreenButtonHeight=SizeConfig.screenHeight*.06;
  static double _VerticalSpaceVerySmall = screenHeight * 0.005;
  static double _VerticalSpaceSmall = screenHeight * 0.01;
  static double _VerticalSpaceSmallMedium = screenHeight * 0.02;
  static double VerticalSpaceMedium = screenHeight * 0.03;
  static double _VerticalSpaceExtraMedium = screenHeight * 0.04;
  static double _VerticalSpaceBigMedium = screenHeight * 0.05;
  static double _VerticalSpaceLarge = screenHeight * 0.07;
  static double _VerticalSpaceELarge=screenHeight*.11;
  static double _verticalSpaceLargeBig = screenHeight * 0.14;
  static double _verticalSpaceBig = screenHeight * 0.12;
  static double _verticalSpaceExtraLarge = screenHeight * 0.2;

  // Vertical spacing constants. Adjust to your liking.
  static const double HorizontalSpaceSmall = 10.0;
  static const double _HorizontalSpaceMedium = 20.0;
  static const double HorizontalSpaceLarge = 60.0;
  static const double HorizontalSpaceBig = 40.0;
  static  double ContainerHeight_widthLarge = screenHeight*.15;

  //image height
  static const double smallerImageHeight=45;
  static const double smallImageHeight55=55;
  static const double smallImageHeight60=60;

  static const double smallImageheight=80;
  static const double orderStatusContainerheight=235;
  static const double imageheight90=90;
  static const double smallerImageheight=70;
  static const double smallerImageheight75=75;
  static const double mediumImageheight=100;
  static const double BigImageheight=120;
  static const double BigerImageheight=130;
  static const double imageHeight140=140;
  static  double imageHeight160=screenHeight*.2;



  /// Returns a vertical space with height set to [_VerticalSpaceSmall]
  static Widget verticalSpaceVerySmall() {
    return verticalSpace(_VerticalSpaceVerySmall);
  }
  static Widget verticalSpaceVeryGap() {
    return verticalSpace(2);
  }
  static Widget horizontalSpaceVeryGap() {
    return horizontalSpace(2);
  }
  static Widget verticalSpaceSmall() {
    return verticalSpace(_VerticalSpaceSmall);
  }

  /// Returns a vertical space with height set to [_VerticalSpaceSmallMedium]
  static Widget VerticalSpaceSmallMedium() {
    return verticalSpace(_VerticalSpaceSmallMedium);
  }
  static Widget VerticalSpaceExtraLarge() {
    return verticalSpace(_VerticalSpaceELarge);
  }
  static Widget CVerticalSpaceSmallMedium() {
    return verticalSpace(10);
  }
  static Widget CVerticalSpaceSmallMediumC11() {
    return verticalSpace(11);
  }
  static Widget CVerticalSpaceSmallMediumC12() {
    return verticalSpace(12);
  }

  static Widget CVerticalSpacevMedium() {
    return verticalSpace(15);
  }
  static Widget CVerticalSpaceVarySmall() {
    return verticalSpace(5);
  }
  static Widget CVerticalSpaceMedium() {
    return verticalSpace(20);
  }
  static Widget CVerticalSpaceMedium25() {
    return verticalSpace(25);
  }
  static Widget CVerticalSpacevEMedium() {
    return verticalSpace(30);
  }

  static Widget CVerticalSpaceBig() {
    return verticalSpace(40);
  }
  static Widget CVerticalSpaceBig43() {
    return verticalSpace(43);
  }
  static Widget CVerticalSpaceBigger() {
    return verticalSpace(45);
  }
  static Widget CVerticalSpace55() {
    return verticalSpace(55);
  }
  static Widget CVerticalSpace60() {
    return verticalSpace(60);
  }
  static Widget CVerticalSpaceExtraBig() {
    return verticalSpace(70);
  }
  static Widget CVerticalSpaceExtra80() {
    return verticalSpace(80);
  }
  static Widget CVerticalSpaceExtra90() {
    return verticalSpace(90);
  }
  static Widget CVerticalSpaceExtra110() {
    return verticalSpace(110);
  }

  /// Returns a vertical space with height set to [VerticalSpaceMedium]
  static Widget verticalSpaceESmall() {
    return verticalSpace(_VerticalSpaceSmallMedium);
  }

  static Widget verticalSpaceMedium() {
    return verticalSpace(VerticalSpaceMedium);
  }

  static Widget verticalSpaceExtraMedium() {
    return verticalSpace(_VerticalSpaceExtraMedium);
  }

  static Widget verticalSpaceBigMedium() {
    return verticalSpace(_VerticalSpaceBigMedium);
  }

  /// Returns a vertical space with height set to [_VerticalSpaceLarge]
  static Widget verticalSpaceLarge() {
    return verticalSpace(_VerticalSpaceLarge);
  }

  static Widget verticalSpaceLargeBig() {
    return verticalSpace(_verticalSpaceLargeBig);
  }
  static Widget verticalSpaceBig() {
    return verticalSpace(_verticalSpaceBig);
  }

  static Widget verticalSpaceExtraLarge() {
    return verticalSpace(_verticalSpaceExtraLarge);
  }

  /// Returns a vertical space equal to the [height] supplied
  static Widget verticalSpace(double height) {
    return Container(height: height);
  }

  /// Returns a vertical space with height set to [HorizontalSpaceSmall]
  static Widget horizontalSpaceSmall() {
    return horizontalSpace(HorizontalSpaceSmall);
  }
  static Widget horizontalSpaceGap() {
    return horizontalSpace(3);
  }


  /// Returns a vertical space with height set to [_HorizontalSpaceMedium]
  static Widget horizontalSpaceMedium() {
    return horizontalSpace(_HorizontalSpaceMedium);
  }
  static EdgeInsets get topAppbarPadding=>EdgeInsets.only(top: SizeConfig.screenHeight * 0.02);

  static EdgeInsets get constantSidePadding=>EdgeInsets.only(
      left: 20,right:20 ) ;
  static EdgeInsets get constantPadding=>EdgeInsets.only(
      left: 20,right:20,top: 20,
      bottom:  20) ;
  static EdgeInsets get topSPadding=>EdgeInsets.only(top: screenHeight*.05) ;
  static EdgeInsets get smallertopPadding=>EdgeInsets.only(top: screenHeight*.04,
  left:screenWidth * 0.012 ) ;
  static EdgeInsets get topIconPadding=>EdgeInsets.only(
      right:screenWidth * 0.04,top: screenHeight*.08,) ;
  static EdgeInsets get mediumTopPadding=>EdgeInsets.only(top: screenHeight*.1,) ;
  static EdgeInsets get topPadding=>EdgeInsets.only(
      left:SizeConfig.screenWidth * 0.05,top: screenHeight*.08);
  static EdgeInsets get smalltopPadding=>EdgeInsets.only(
      left:SizeConfig.screenWidth * 0.05,top: _topPadding,
  right:SizeConfig.screenWidth * 0.05 );
  static EdgeInsets get columntopPadding=>EdgeInsets.only(
      top: screenHeight*.1);
  static EdgeInsets get sidepadding=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04 ) ;
  static EdgeInsets get tilesPadding=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04 ,bottom: screenHeight * 0.0125) ;
  static EdgeInsets get largeSidepadding=>EdgeInsets.only(
      left: screenWidth * 0.15) ;
  static EdgeInsets get largerSidepadding=>EdgeInsets.only(
      left: screenWidth * 0.1,right: screenWidth * 0.1) ;
  static EdgeInsets get sidelargepadding=>EdgeInsets.only(
      left: 30,right:30 ) ;
  static EdgeInsets get innersidepadding=>EdgeInsets.only(
      left: screenWidth * 0.02,right:screenWidth * 0.02 ) ;
  static EdgeInsets get innerMediumPadding=>EdgeInsets.only(
      left: screenWidth * 0.03,right:screenWidth * 0.03 ,top: screenHeight*.008,
      bottom:  screenHeight*.008) ;
  static EdgeInsets get padding=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04,top: screenHeight*.01,
  bottom:  screenHeight*.01) ;
  static EdgeInsets get paddingWithHighVerticalSpace=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04,top: screenHeight*.023,
      bottom:  screenHeight*.023) ;

  static EdgeInsets get paddingMediumhighSide=>EdgeInsets.only(
      left: screenWidth * 0.043,right:screenWidth * 0.043,top: screenHeight*.016,
      bottom:  screenHeight*.016) ;
  static EdgeInsets get smallpadding=>EdgeInsets.only(
      left: screenWidth * 0.02,right:screenWidth * 0.02,top: screenHeight*.005,
      bottom:  screenHeight*.005) ;
  static EdgeInsets get paddingWihLittleHeight=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04,top: screenHeight*.015,
      bottom:  screenHeight*.015) ;
  static EdgeInsets get paddingWihLittleHeight018=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04,top: screenHeight*.018,
      bottom:  screenHeight*.018) ;
  static EdgeInsets get mediumpadding=>EdgeInsets.only(
      left: screenWidth * 0.05,right:screenWidth * 0.05,top: screenHeight*.015,
      bottom:  screenHeight*.015) ;
  static EdgeInsets get innerpadding=>EdgeInsets.only(
      left: screenWidth * 0.02,right:screenWidth * 0.02,top: screenHeight*.016,
      bottom:  screenHeight*.016) ;
  static EdgeInsets get innerSidepadding=>EdgeInsets.only(
      left: screenWidth * 0.02,right:screenWidth * 0.02,) ;
  static EdgeInsets get innerSideLargePadding=>EdgeInsets.only(
    left: screenWidth * 0.03,right:screenWidth * 0.03,) ;
  static EdgeInsets get smallInnerSidePadding=>EdgeInsets.only(
    left: screenWidth * 0.005,right:screenWidth * 0.005,) ;
  static EdgeInsets get smallinnerpadding=>EdgeInsets.only(
      left: screenWidth * 0.02,right:screenWidth * 0.02,top: screenHeight*.005,
      bottom:  screenHeight*.005) ;
  static EdgeInsets get paddingHeighy02=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04,top: screenHeight*.012,
      bottom:  screenHeight*.012) ;
  static EdgeInsets get paddingHeighy01=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04,top: screenHeight*.008,
      bottom:  screenHeight*.008) ;
  static EdgeInsets get smalltpadding=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04,top: screenHeight*.005,
      bottom:  screenHeight*.007) ;

  static EdgeInsets get smallerpadding=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04,top: screenHeight*.0025,
      bottom:  screenHeight*.0025) ;
  static EdgeInsets get largePadding=>EdgeInsets.only(
      left: screenWidth * 0.12,right:screenWidth * 0.12,top: screenHeight*.01,
      bottom:  screenHeight*.01) ;
  static EdgeInsets get mediumPadding=>EdgeInsets.only(
      left: screenWidth * 0.037,right:screenWidth * 0.037,top: screenHeight*.016,
      bottom:  screenHeight*.016) ;
  static EdgeInsets get mediumCPadding=>EdgeInsets.only(
      left: screenWidth * 0.037,right:screenWidth * 0.037,top: 13,
      bottom:  13) ;
  static EdgeInsets get smallerPadding=>EdgeInsets.only(
      left: screenWidth * 0.037,right:screenWidth * 0.037,top: screenHeight*.02,
      bottom:  screenHeight*.02) ;
  static EdgeInsets get cmediumPadding=>EdgeInsets.only(
      left: screenWidth * 0.05,right:screenWidth * 0.05,top: SizeConfig.screenHeight*.018,
      bottom:  SizeConfig.screenHeight*.018) ;
  static EdgeInsets get verticalPadding=>EdgeInsets.only(
      bottom:screenHeight * 0.01,top: screenHeight*.01) ;
  static EdgeInsets get bottomPadding=>EdgeInsets.only(
      bottom:screenHeight * 0.025,) ;
  static EdgeInsets get bottomsmallPadding=>EdgeInsets.only(
    bottom:screenHeight * 0.005,);
  static EdgeInsets get cBottomSmallPadding=>EdgeInsets.only(
    bottom:10,);
  static EdgeInsets get verticalBigPadding=>EdgeInsets.only(
      bottom:screenHeight * 0.009,top: screenHeight*.009) ;
  static EdgeInsets get verticalLarPadding=>EdgeInsets.only(
      bottom:SizeConfig.screenHeight*.03,top: SizeConfig.screenHeight*.03) ;
  static EdgeInsets get verticalMedPadding=>EdgeInsets.only(
      bottom:SizeConfig.screenHeight*.02,top: SizeConfig.screenHeight*.02) ;
  static EdgeInsets get bottomBarPadding=>EdgeInsets.only(
      bottom:SizeConfig.screenHeight*.03,top: SizeConfig.screenHeight*.01) ;
  static EdgeInsets get verticalC13Padding=>EdgeInsets.only(
      bottom:13,top: 13) ;
  static EdgeInsets get paddingC13=>EdgeInsets.only(
    left: 13,right: 13,
      bottom:13,top: 13) ;
  static EdgeInsets get verticalMediumPadding=>EdgeInsets.only(
      bottom:screenHeight * 0.004,top: screenHeight*.013) ;
  static EdgeInsets get sidebottompadding=>EdgeInsets.only(
      left: screenWidth * 0.04,right:screenWidth * 0.04 ,bottom: screenHeight*.015) ;
  static EdgeInsets get bigPadding=>EdgeInsets.only(
      left: screenWidth * 0.05,right:screenWidth * 0.05,top: screenHeight*.04,
      bottom:  screenHeight*.04) ;
  static EdgeInsets get csmallmediumPadding=>EdgeInsets.only(
      left: screenWidth * 0.05,right:screenWidth * 0.05,top: 5,
      bottom:  5) ;
  static EdgeInsets get smallVerticalPadding=>EdgeInsets.only(
      top: 11,
      bottom:  11) ;
  static EdgeInsets get smallLeftPadding=>EdgeInsets.only(
      left: 10,) ;
  static EdgeInsets get cSmallVerticalPadding=>EdgeInsets.only(
      top: 8,
      bottom:  8) ;
  static EdgeInsets get smallerVerticalPadding=>EdgeInsets.only(
      top: 5,
      bottom:  5) ;
  static EdgeInsets get smallerVerticalPadding3=>EdgeInsets.only(
      top: 3,
      bottom:  3) ;
  static EdgeInsets get bottomsidePadding=>EdgeInsets.only(
      left: screenWidth * 0.043,right:screenWidth * 0.043,
      bottom:  50) ;


  /// Returns a vertical space with height set to [HorizontalSpaceLarge]
  static Widget horizontalSpaceLarge() {
    return horizontalSpace(HorizontalSpaceLarge);
  }
  static Widget horizontalSpaceBig() {
    return horizontalSpace(HorizontalSpaceBig);
  }

  /// Returns a vertical space equal to the [width] supplied
  static Widget horizontalSpace(double width) {
    return SizedBox(width: width);
  }
  static Widget dotWidget(Color color,height){
    return  Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:color,

      ),
    );
  }
  static SliverToBoxAdapter verticalSliverSmallSpace(){
    return SliverToBoxAdapter(
      child: verticalSpace(SizeConfig.screenHeight*.015),
    );
  }
  static SliverToBoxAdapter verticalSliverMediumSpace(){
    return SliverToBoxAdapter(
      child: verticalSpace(SizeConfig.screenHeight*.03),
    );
  }

  static SliverToBoxAdapter verticalSliverLargeSpace(){
    return SliverToBoxAdapter(
      child: verticalSpace(SizeConfig.screenHeight*.04),
    );
  }

  static void setMobileSize(int height, int width){
    if(height<780){
      mobileSize = MobileSize.small;
      mobileSizeScaleFactorVertical = 1.4;
      mobileSizeScaleFactorHorizontal = 0.7;
    }else {
      mobileSize = MobileSize.medium;
      mobileSizeScaleFactorVertical = 1.0;
      mobileSizeScaleFactorHorizontal = 1.0;
    }
  }
  static BorderRadius get appReverseItemShapeRadius{
    return  BorderRadius.only(
      topLeft: Radius.circular(SizeConfig.borderRadius),
      topRight: Radius.circular(SizeConfig.borderRadius),
    );
  }
  static BorderRadius get appItemShapeRadius{
    return  BorderRadius.only(
      bottomLeft: Radius.circular(SizeConfig.borderRadius),
      bottomRight: Radius.circular(SizeConfig.borderRadius),
      topRight: Radius.circular(SizeConfig.borderRadius),
    );
  }
  static BorderRadius get circularBorder{
    return  BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
      topRight: Radius.circular(30),
      topLeft: Radius.circular(30),
    );
  }
  static BorderRadius get appItemReverseShapeRadius{
    return  BorderRadius.only(
      bottomLeft: Radius.circular(SizeConfig.borderRadius),
      bottomRight: Radius.circular(SizeConfig.borderRadius),
      topLeft: Radius.circular(SizeConfig.borderRadius),
    );
  }
}
