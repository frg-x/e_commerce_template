part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {
  List<CartItem> cart = [];
  double cartSum = 0;
  int cartItemCount = 0;
  CartInitial(this.cart, this.cartSum, this.cartItemCount);
}
