part of 'favorite_cubit.dart';

abstract class GetFavoriteState {
  const GetFavoriteState();
}

class GetFavoriteInitial extends GetFavoriteState {
  const GetFavoriteInitial();
}

class GetFavoriteLoading extends GetFavoriteState {
  const GetFavoriteLoading();
}

class GetFavoriteError extends GetFavoriteState {
  final message;
  const GetFavoriteError(this.message);
}

class GetFavoriteLoaded extends GetFavoriteState {
  final List<String> favoriteProductsIds;
  final List<Product> favoriteProducts;
  const GetFavoriteLoaded(this.favoriteProductsIds, this.favoriteProducts);
}
