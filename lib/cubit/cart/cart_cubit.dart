import 'package:bloc/bloc.dart';
import 'package:e_commerce_template/model/cart_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<CartItem> cart = [];
  double cartSum = 0;
  int cartItemCount = 0;
  CartCubit(this.cart, this.cartSum, this.cartItemCount)
      : super(CartInitial(cart, cartSum, cartItemCount));

  void addToCart(CartItem cartProduct) {
    var existItem = cart.firstWhereOrNull((element) =>
        element.id == cartProduct.id &&
        element.size == cartProduct.size &&
        element.color == cartProduct.color);

    if (existItem != null) {
      existItem.quantity += 1;
    } else {
      cart.add(cartProduct);
    }

    countTotalSum();
    getItemsCount();
    emit(CartInitial(this.cart, this.cartSum, this.cartItemCount));
  }

  void clearCart() {
    this.cart = [];
    this.cartSum = 0;
    cartItemCount = 0;
    emit(CartInitial(this.cart, this.cartSum, this.cartItemCount));
  }

  void getItemsCount() {
    cartItemCount = 0;
    int count = 0;
    cart.forEach((element) {
      count += element.quantity;
    });
    cartItemCount = count;
  }

  void countTotalSum() {
    cartSum = 0;
    double sum = 0;
    cart.forEach((element) {
      sum += element.price * element.quantity;
    });
    cartSum = sum;
  }

  void increment(CartItem cartProduct) {
    CartItem existItem = cart.firstWhere((element) =>
        element.id == cartProduct.id &&
        element.size == cartProduct.size &&
        element.color == cartProduct.color);
    existItem.quantity += 1;
    countTotalSum();
    getItemsCount();
    emit(CartInitial(this.cart, this.cartSum, this.cartItemCount));
  }

  void decrement(CartItem cartProduct) {
    CartItem existItem = cart.firstWhere((element) =>
        element.id == cartProduct.id &&
        element.size == cartProduct.size &&
        element.color == cartProduct.color);
    if (existItem.quantity > 1) {
      existItem.quantity -= 1;
    } else {
      int index = cart.indexWhere((element) =>
          element.id == cartProduct.id &&
          element.size == cartProduct.size &&
          element.color == cartProduct.color);
      cart.removeAt(index);
    }
    countTotalSum();
    getItemsCount();
    emit(CartInitial(this.cart, this.cartSum, this.cartItemCount));
  }
}
