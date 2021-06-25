import 'package:bloc/bloc.dart';
import 'package:e_commerce_template/screens/sign_and_verify_screens/get_started_screen.dart';
import 'package:e_commerce_template/screens/tabs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'user_status_state.dart';

class UserStatusCubit extends Cubit<IsLoggedState> {
  UserStatusCubit() : super(UserCheckingState());

  late Widget initialScreen;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLogged = false;
  User? user;
  String phoneNumber = '';

  void checkUserStatus() {
    auth.authStateChanges().listen((currentUser) {
      print('checkUserStatus');
      if (currentUser == null) {
        isLogged = false;
        initialScreen = GetStarted();
        print('----NotLoggedInState');
        emit(NotLoggedInState());
      } else {
        user = currentUser;
        isLogged = true;
        initialScreen = TabsScreen();
        print('----LoggedInState');
        emit(LoggedInState());
      }
    });
  }

  void logOut() {
    isLogged = false;
    user = null;
    phoneNumber = '';
    emit(NotLoggedInState());
  }
}
