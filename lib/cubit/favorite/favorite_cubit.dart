import 'package:bloc/bloc.dart';
import 'package:e_commerce_template/data/shop_repository.dart';
import 'package:e_commerce_template/model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'favorite_state.dart';

class FavoriteCubit extends Cubit<GetFavoriteState> {
  final ShopRepository _shopRepository;
  String userId = '';
  List<String> favProductsIds = [];
  List<Product> favoriteProducts = [];
  List<Product> allProducts = [];
  bool isLogged = false;
  FavoriteCubit(this._shopRepository) : super(GetFavoriteInitial());

  Future<void> setUserId(String uid) async {
    userId = uid;
    isLogged = true;
  }

  Future<void> getFavorite() async {
    try {
      favProductsIds = [];
      favoriteProducts = [];
      allProducts = await _shopRepository.fetchProducts();
      favProductsIds = await _shopRepository.getUserFavoriteProducts(
          uid: userId) as List<String>;
      allProducts.forEach((element) {
        if (favProductsIds.contains(element.id)) {
          favoriteProducts.add(element);
        }
      });

      emit(GetFavoriteLoaded(favProductsIds, favoriteProducts));
    } on NetworkException {
      emit(GetFavoriteError(
          "Couldn't fetch advertisements. Is the device online?"));
    }
  }

  Future<void> toggleFavorite(Product product) async {
    try {
      if (favProductsIds.contains(product.id)) {
        int favProdIndex =
            favProductsIds.indexWhere((element) => element == product.id);
        favProductsIds.removeAt(favProdIndex);
        int favIndex =
            favoriteProducts.indexWhere((element) => element.id == product.id);
        favoriteProducts.removeAt(favIndex);
      } else {
        favProductsIds.add(product.id);
        favoriteProducts.add(product);
      }

      _shopRepository.toggleFavoriteProduct(uid: userId, productId: product.id);
      emit(GetFavoriteLoaded(favProductsIds, favoriteProducts));
    } on NetworkException {
      emit(GetFavoriteError(
          "Couldn't change favorite item. Is the device online?"));
    }
  }

  void clearFavorites() {
    isLogged = false;
    favoriteProducts = [];
    favProductsIds = [];
    favoriteProducts = [];
    userId = '';
  }
}
