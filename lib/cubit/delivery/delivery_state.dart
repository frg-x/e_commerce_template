part of 'delivery_cubit.dart';

@immutable
abstract class DeliveryState {}

class DeliveryInitial extends DeliveryState {
  final int cost;
  DeliveryInitial(this.cost);
}
