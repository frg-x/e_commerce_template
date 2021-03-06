import 'package:bloc/bloc.dart';
part 'toggle_botnavbar_state.dart';

class ToggleBotNavBarCubit extends Cubit<ToggleBotNavBarState> {
  ToggleBotNavBarCubit() : super(ToggleBotNavBarInitial()) {
    toggleBottomNavBarMenu(selectedIndex);
  }

  int selectedIndex = 0;
  int lastSelectedIndex = 0;

  void toggleBottomNavBarMenu(int index) {
    lastSelectedIndex = selectedIndex;
    selectedIndex = index;
    emit(GetSelectedIndex(selectedIndex));
  }
}
