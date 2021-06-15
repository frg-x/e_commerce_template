import 'package:bloc/bloc.dart';
import 'package:e_commerce_template/screens/get_started_screen.dart';
import 'package:e_commerce_template/screens/tabs_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'user_status_state.dart';

class UserStatusCubit extends Cubit<IsLoggedState> {
  UserStatusCubit() : super(UserCheckingState());

  Widget initialScreen = GetStarted();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLogged = false;
  User? user;

  void checkUserStatus() {
    auth.authStateChanges().listen((User? currentUser) {
      if (currentUser == null) {
        isLogged = false;
        initialScreen = GetStarted();
        emit(NotLoggedInState());
      } else {
        user = currentUser;
        isLogged = true;
        initialScreen = TabsScreen();
        emit(LoggedInState());
      }
    });
  }
}
