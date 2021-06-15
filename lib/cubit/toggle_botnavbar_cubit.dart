import 'package:bloc/bloc.dart';
part 'toggle_botnavbar_state.dart';

class ToggleBotNavBarCubit extends Cubit<ToggleBotNavBarState> {
  ToggleBotNavBarCubit() : super(ToggleBotNavBarInitial());
  int selectedIndex = 0;
  int lastSelectedState = 0;

  void toggleBottomNavBarMenu(int index) {
    lastSelectedState = selectedIndex;
    selectedIndex = index;
    emit(GetSelectedIndex(selectedIndex));
  }
}
