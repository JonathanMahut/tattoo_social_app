import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:tattoo_social_app/data/current_user_data.dart';
import 'package:tattoo_social_app/providers/current_user_data_provider.dart'; // Import Provider

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signIn(String email, String password,
      GlobalKey<NavigatorState> navigatorKey) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _updateCurrentUserData(result.user, navigatorKey);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> signUp(String email, String password,
      GlobalKey<NavigatorState> navigatorKey) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _updateCurrentUserData(result.user, navigatorKey);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut(GlobalKey<NavigatorState> navigatorKey) async {
    await _auth.signOut();
    _updateCurrentUserData(null, navigatorKey);
  }

  Future<User?> signInWithGoogle(GlobalKey<NavigatorState> navigatorKey) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      _updateCurrentUserData(userCredential.user, navigatorKey);
      return userCredential.user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<User?> signInWithFacebook(
      GlobalKey<NavigatorState> navigatorKey) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        final accessToken = loginResult.accessToken;

        if (accessToken == null) {
          print('Facebook access token is null');
          return null;
        }

        final facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken.tokenString);
        final UserCredential userCredential =
            await _auth.signInWithCredential(facebookAuthCredential);
        _updateCurrentUserData(userCredential.user, navigatorKey);
        return userCredential.user;
      } else {
        print('Facebook login failed with status: ${loginResult.status}');
        return null;
      }
    } catch (e) {
      print('Error signing in with Facebook: $e');
      return null;
    }
  }

  void _updateCurrentUserData(
      User? user, GlobalKey<NavigatorState> navigatorKey) {
    final currentUserDataProvider = Provider.of<CurrentUserDataProvider>(
        navigatorKey.currentContext!,
        listen: false);
    currentUserDataProvider.currentUser =
        user != null ? CurrentUserData(id: user.uid) : null;
  }
}
