import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/api_helpers/api_error_handler.dart';
import '../../../../core/api_helpers/api_result.dart';
import '../apis/social_api_service.dart';

class SocialAuthRepo {
  final SocialApiService _socialApiService;

  SocialAuthRepo(this._socialApiService);

  /// Sign in with Google
  /// Returns ApiResult with user data on success or error on failure
  Future<ApiResult<Map<String, dynamic>>> signInWithGoogle() async {
    try {
      log('SocialAuthRepo: Starting Google sign-in process');
      final userData = await _socialApiService.signInWithGoogle();
      log('SocialAuthRepo: Google sign-in successful');
      return ApiResult.success(userData);
    } catch (error) {
      log('SocialAuthRepo: Google sign-in failed - $error');
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  /// Sign in with Facebook
  /// Returns ApiResult with user data on success or error on failure
  Future<ApiResult<User>> signInWithFacebook() async {
    try {
      log('SocialAuthRepo: Starting Facebook sign-in process');
      final userData = await _socialApiService.signInWithFacebook();
      log('SocialAuthRepo: Facebook sign-in successful');
      return ApiResult.success(userData.user!);
    } catch (error) {
      log('SocialAuthRepo: Facebook sign-in failed - $error');
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  /// Sign out from Google
  /// Returns ApiResult with success status
  Future<ApiResult<void>> signOutGoogle() async {
    try {
      log('SocialAuthRepo: Starting Google sign-out process');
      await _socialApiService.signOutGoogle();
      log('SocialAuthRepo: Google sign-out successful');
      return ApiResult.success(null);
    } catch (error) {
      log('SocialAuthRepo: Google sign-out failed - $error');
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  /// Sign out from Facebook
  /// Returns ApiResult with success status
  Future<ApiResult<void>> signOutFacebook() async {
    try {
      log('SocialAuthRepo: Starting Facebook sign-out process');
      await _socialApiService.signOutFacebook();
      log('SocialAuthRepo: Facebook sign-out successful');
      return ApiResult.success(null);
    } catch (error) {
      log('SocialAuthRepo: Facebook sign-out failed - $error');
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  /// Sign out from all social providers
  /// Returns ApiResult with success status
  Future<ApiResult<void>> signOutAll() async {
    try {
      log('SocialAuthRepo: Starting sign-out from all providers');
      await _socialApiService.signOutAll();
      log('SocialAuthRepo: Sign-out from all providers successful');
      return ApiResult.success(null);
    } catch (error) {
      log('SocialAuthRepo: Sign-out from all providers failed - $error');
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  /// Check if user is signed in with Google
  /// Returns ApiResult with boolean status
  Future<ApiResult<bool>> isSignedInWithGoogle() async {
    try {
      final isSignedIn = await _socialApiService.isSignedInWithGoogle();
      return ApiResult.success(isSignedIn);
    } catch (error) {
      log('SocialAuthRepo: Check Google sign-in status failed - $error');
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  /// Check if user is signed in with Facebook
  /// Returns ApiResult with boolean status
  Future<ApiResult<bool>> isSignedInWithFacebook() async {
    try {
      final isSignedIn = await _socialApiService.isSignedInWithFacebook();
      return ApiResult.success(isSignedIn);
    } catch (error) {
      log('SocialAuthRepo: Check Facebook sign-in status failed - $error');
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
