import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  int cost;
  DeliveryCubit(this.cost) : super(DeliveryInitial(cost)) {
    getDeliveryCost();
  }

  void clearDeliveryCost() {
    cost = 0;
    emit(DeliveryInitial(this.cost));
  }

  void getDeliveryCost() {
    emit(DeliveryInitial(this.cost));
  }
}
