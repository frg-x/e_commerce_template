part of 'toggle_botnavbar_cubit.dart';

abstract class ToggleBotNavBarState {}

class ToggleBotNavBarInitial extends ToggleBotNavBarState {}

class GetSelectedIndex extends ToggleBotNavBarState {
  GetSelectedIndex(this.index);
  int index;
}
