part of 'user_status_cubit.dart';

abstract class IsLoggedState {
  const IsLoggedState();
}

class LoggedInState extends IsLoggedState {
  const LoggedInState();
}

class NotLoggedInState extends IsLoggedState {
  const NotLoggedInState();
}

class UserCheckingState extends IsLoggedState {
  const UserCheckingState();
}
