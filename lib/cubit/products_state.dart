part of 'products_cubit.dart';

abstract class GetProductsState {
  const GetProductsState();
}

class GetProductsInitial extends GetProductsState {
  const GetProductsInitial();
}

class GetProductsLoading extends GetProductsState {
  const GetProductsLoading();
}

class GetProductsError extends GetProductsState {
  final message;
  const GetProductsError(this.message);
}

class GetProductsLoaded extends GetProductsState {
  final List<Product> products;
  const GetProductsLoaded(this.products);

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
