
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/consts/apptheme.dart';
import 'package:storeangelApp/core/models/app_initiale_value.dart';
import 'package:storeangelApp/core/services/auth_service.dart';
import 'package:storeangelApp/core/viewmodel/apptheme_viewmodel.dart';
import 'package:storeangelApp/getIt.dart';
import 'package:storeangelApp/ui/screens/consumer/login_Screen.dart';
import 'package:easy_localization/easy_localization.dart';


class MockAuth extends Mock implements AuthBase{}
void main(){
  setupLocator();

  MockAuth mockAuth;
  setUp((){
    mockAuth=MockAuth();
  });

  Future<void>pumpEmailSignInForm(WidgetTester tester)async{
    await tester.pumpWidget(
      MultiProvider(
        providers: [
      Provider<AuthBase>(
      create: (_)=>mockAuth),

          ChangeNotifierProvider.value(value: AppThemeViewModel(AppTheme.light, AppInitialValue(
              darkMode: false,
              isAlready: true,
              opacity: 0,
              isBackgroundImageActive:  false,
              backGroundImagePath: '')))
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Scaffold(
              body: LoginScreen(),
            ),
          ),
        ),
      )
    );
  }

  group('Sign In',(){

    testWidgets('WHEN user doesn\'t enter the email and password'
        'AND user taps on the sign-in button'
        'THEN signInWithEmailAndPassword is not called'
        'AND user is not signed-in', (WidgetTester tester)async{

      await pumpEmailSignInForm(tester);
      final signInButton=find.text('login');
      await tester.tap(signInButton);

      verifyNever(mockAuth.signUpUserWithEmailAndPassword(any, any));

    });
    testWidgets('WHEN user enters a valid email and password'
        'AND user taps on the sign-in button'
        'THEN signInWithEmailAndPassword is called'
        'AND user is signed in', (WidgetTester tester)async{

      await pumpEmailSignInForm(tester);
      const email='email@email.com';
      const password='password';
      final emailField=find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);
      final passwordField=find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);
      await tester.pump();
      final signInButton=find.text(AppStrings.LOGIN.tr());
      await tester.tap(signInButton);

      verifyNever(mockAuth.signUpUserWithEmailAndPassword(email, password)).called(1);

    });
  });


}