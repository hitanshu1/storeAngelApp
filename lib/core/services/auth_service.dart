import 'dart:async';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:storeangelApp/core/consts/appString.dart';
import 'package:storeangelApp/core/models/auth_responsemodel.dart';
import 'package:storeangelApp/core/models/response_model.dart';
import 'package:storeangelApp/core/models/user.dart';

import '../../getIt.dart';
import 'firebase_abstraction.dart';

abstract class AuthBase {
  Stream<UserModel> get onAuthStateChanged;

  Future<UserModel> currentUser();

  Future<UserModel> signInAnonymously();

  Future<AuthResponseModel> loginWithEmailAndPassword(String email, String password);

  Future<AuthResponseModel> signUpUserWithEmailAndPassword(String email, String password);

  Future<AuthResponseModel> loginWithGoogle();

  Future<AuthResponseModel> signUpAndLoginWithFacebook(String result);

  Future<AuthResponseModel> signUpWithApple();

  Future<AuthResponseModel> loginWithApple();

  Future<void> signOut();

  Future<ResponseModel> forgotUserPassword(String email);
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  FirebaseAbstraction database = getIt<FirebaseAbstraction>();

  UserModel _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }

    return UserModel(
      id: user.uid,
      name: user.displayName,
      imageUrl: user.photoURL,
    );
  }

  @override
  Stream<UserModel> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map((event) => _userFromFirebase(event));
  }

  @override
  Future<UserModel> currentUser() async {
    User user = _firebaseAuth.currentUser;
    if (user != null) {
      return _userFromFirebase(user);
    }
    return _userFromFirebase(user);
  }

  @override
  Future<UserModel> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<AuthResponseModel> loginWithEmailAndPassword(String email, String password) async {
    try {
      final authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (authResult.user.emailVerified) {
        return AuthResponseModel(
            statusCode: 1,
            message: AppStrings.LOGIN_SUCCESS.tr(),
            user: _userFromFirebase(
              authResult.user,
            ));
      } else {
        return AuthResponseModel(
            statusCode: 0,
            message: 'Please verify email',
            user: _userFromFirebase(
              authResult.user,
            ));
      }
    } catch (e) {
      return AuthResponseModel(statusCode: 0, message: e.toString(), user: null);
    }
  }

  Stream<bool> checkUserVerify() {
    StreamController<bool> controller = StreamController<bool>.broadcast();
    bool verify = false;
    _firebaseAuth.authStateChanges().map((event) {
      verify = event.emailVerified;
    });
    controller.sink.add(verify);
    controller.close();
    return controller.stream;
  }

  @override
  Future<AuthResponseModel> signUpUserWithEmailAndPassword(String email, String password) async {
    try {
      final authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      authResult.user.sendEmailVerification();

      return AuthResponseModel(statusCode: 1, message: 'SignUp success', user: _userFromFirebase(authResult.user));
    } catch (e) {
      if(e.message=='The email address is already in use by another account.'){
        return AuthResponseModel(message: AppStrings.THE_EMAIL_ADDRESS_IS_ALREADY.tr(),
        statusCode: 0,user:_userFromFirebase(null) );
      }
      return AuthResponseModel(statusCode: 0, message: e.message.toString(), user: _userFromFirebase(null));
    }
  }

  @override
  Future<AuthResponseModel> loginWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        bool dataExist = await database.checkUserData(_userFromFirebase(authResult.user));
        if (dataExist) {
          ResponseModel responseModel = await database.saveUser((_userFromFirebase(authResult.user)));
          if (responseModel.status == 1) {
            return AuthResponseModel(
                statusCode: 1, message: responseModel.message, user: _userFromFirebase(authResult.user));
          } else {
            return AuthResponseModel(
                statusCode: responseModel.status,
                message: responseModel.message,
                user: _userFromFirebase(authResult.user));
          }
        } else {
          return AuthResponseModel(
              statusCode: 1, message: AppStrings.LOGIN_SUCCESS.tr(), user: _userFromFirebase(authResult.user));
        }
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<AuthResponseModel> signUpAndLoginWithFacebook(String result) async {
    OAuthCredential facebookAuthCred;
    UserCredential user;
    try {
      facebookAuthCred =
//      FacebookAuthProvider.getCredential(accessToken: result);
          FacebookAuthProvider.credential(result);
      user = await _firebaseAuth.signInWithCredential(facebookAuthCred);
    } catch (firebaseAuthException) {
      print('execption: $firebaseAuthException');
      final result = await _firebaseAuth.fetchSignInMethodsForEmail("eichmueller.christian@gmail.com");
      print('result');
    }
    try {
      bool dataExist = await database.checkUserData(_userFromFirebase(user.user));
      if (dataExist) {
        ResponseModel responseModel = await database.saveUser((_userFromFirebase(user.user)));
        if (responseModel.status == 1) {
          return AuthResponseModel(statusCode: 1, message: responseModel.message, user: _userFromFirebase(user.user));
        } else {
          return AuthResponseModel(
              statusCode: responseModel.status, message: responseModel.message, user: _userFromFirebase(user.user));
        }
      } else {
        return AuthResponseModel(
            statusCode: 1, message: AppStrings.LOGIN_SUCCESS.tr(), user: _userFromFirebase(user.user));
      }
    } catch (e) {
      return AuthResponseModel(statusCode: 0, message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<AuthResponseModel> signUpWithApple() async {
    try {
      final result = await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);

      switch (result.status) {
        case AuthorizationStatus.authorized:
          final appleIdCredential = result.credential;
          final oAuthProvider = OAuthProvider('apple.com');
          final credential = oAuthProvider.credential(
              accessToken: String.fromCharCodes(appleIdCredential.authorizationCode),
              idToken: String.fromCharCodes(appleIdCredential.identityToken));
          final authResult = await _firebaseAuth.signInWithCredential(credential);
          bool userExist = await database.checkUserData(_userFromFirebase(authResult.user));
          if (userExist) {
            ResponseModel responseModel = await database.saveUser((_userFromFirebase(authResult.user)));
            if (responseModel.status == 1) {
              return AuthResponseModel(
                  statusCode: 1, message: responseModel.message, user: _userFromFirebase(authResult.user));
            } else {
              return AuthResponseModel(
                  statusCode: responseModel.status,
                  message: responseModel.message,
                  user: _userFromFirebase(authResult.user));
            }
          } else {
            return AuthResponseModel(
                statusCode: 1, message: AppStrings.LOGIN_SUCCESS.tr(), user: _userFromFirebase(authResult.user));
          }
          break;
        case AuthorizationStatus.cancelled:
          print(result.error.toString());
          return AuthResponseModel(statusCode: 0, message: AppStrings.ERROR_ABORTED_BY_USER.tr());
          break;
        case AuthorizationStatus.error:
          print(result.error.toString());
          return AuthResponseModel(statusCode: 0, message: AppStrings.ERROR_AUTHORIZATION_DENIED.tr());
      }
    } catch (e) {
      return AuthResponseModel(statusCode: 0, message: e.toString());
    }
  }

  @override
  Future<ResponseModel> forgotUserPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);

      return ResponseModel(status: 1, message: 'pass');
    } catch (e) {
      return ResponseModel(status: 0, message: '$e');
    }
  }

  @override
  Future<AuthResponseModel> loginWithApple() {
    throw UnimplementedError();
  }
}
