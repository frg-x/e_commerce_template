part of 'filter_cubit.dart';

abstract class FilterState {}

class FilterInitial extends FilterState {
  Filter filter;
  FilterInitial(this.filter);
}
