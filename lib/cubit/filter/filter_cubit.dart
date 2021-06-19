import 'package:bloc/bloc.dart';
import 'package:e_commerce_template/model/filter.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  Filter filter;
  FilterCubit(this.filter) : super(FilterInitial(filter));

  void clearFilter() {
    filter.clear();
    emit(FilterInitial(filter));
  }
}
