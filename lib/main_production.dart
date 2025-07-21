import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'core/di/dependency_injection.dart';
import 'core/helpers/bloc_observer.dart';

import 'core/helpers/constants.dart';
import 'core/helpers/shared_pref_helper.dart';
import 'doctor_app.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupGetIt();
  checkUserLoggedIn();
  runApp(const DoctorApp());
}

void checkUserLoggedIn() {
  if (SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken) != null) {
    // User is logged in
    isLoggedInUser = true;
    log("User is logged in");
  } else {
    // User is not logged in
    isLoggedInUser = false;
    log("User is not logged in");
  }
}
