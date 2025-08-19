import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SocialApiService {
  /// Sign in with Google
  /// Returns a map containing user data and access token
  /// Throws exception if sign-in fails or is cancelled
  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      // Note: Google Sign-In implementation will be added once the package issues are resolved
      // For now, throwing an exception to indicate it's not implemented
      throw Exception(
        'Google Sign-In implementation is pending due to package configuration',
      );
    } catch (e) {
      log('Google Sign-In error: $e');
      rethrow;
    }
  }

  /// Sign in with Facebook
  /// Returns a map containing user data and access token
  /// Throws exception if sign-in fails or is cancelled

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken as String);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(
      facebookAuthCredential,
    );
  }

  /// Sign out from Google
  Future<void> signOutGoogle() async {
    try {
      // Note: Google Sign-Out implementation will be added once the package issues are resolved
      log('Google Sign-Out not implemented yet');
    } catch (e) {
      log('Error signing out from Google: $e');
      throw Exception('Failed to sign out from Google');
    }
  }

  /// Sign out from Facebook
  Future<void> signOutFacebook() async {
    try {
      await FacebookAuth.instance.logOut();
      log('Facebook Sign-Out successful');
    } catch (e) {
      log('Error signing out from Facebook: $e');
      throw Exception('Failed to sign out from Facebook');
    }
  }

  /// Sign out from all social providers
  Future<void> signOutAll() async {
    await Future.wait([signOutGoogle(), signOutFacebook()]);
  }

  /// Check if user is currently signed in with Google
  Future<bool> isSignedInWithGoogle() async {
    try {
      // For now, we'll just return false and handle this in the UI layer
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Check if user is currently signed in with Facebook
  Future<bool> isSignedInWithFacebook() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    return accessToken != null;
  }
}
