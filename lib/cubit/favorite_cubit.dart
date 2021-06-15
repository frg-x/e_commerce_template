import 'package:bloc/bloc.dart';
import 'package:e_commerce_template/data/shop_repository.dart';
part 'favorite_state.dart';

class FavoriteCubit extends Cubit<GetFavoriteState> {
  final ShopRepository _shopRepository;
  String userId = '';
  List<String> favProducts = [];
  bool isLogged = false;

  FavoriteCubit(this._shopRepository) : super(GetFavoriteInitial());

  Future<void> setUserId(String uid) async {
    userId = uid;
    isLogged = true;
  }

  Future<void> getFavorite() async {
    try {
      var fav = await _shopRepository.getUserFavoriteProducts(uid: userId);
      favProducts = fav as List<String>;
      emit(GetFavoriteLoaded(favProducts));
    } on NetworkException {
      emit(GetFavoriteError(
          "Couldn't fetch advertisements. Is the device online?"));
    }
  }

  Future<void> toggleFavorite(String productId) async {
    try {
      emit(ToggleFavorite());
      await _shopRepository.toggleFavoriteProduct(
          uid: userId, productId: productId);
      //print(productId);
      //print(userId);
      favProducts = await _shopRepository.getUserFavoriteProducts(uid: userId)
          as List<String>;
      emit(GetFavoriteLoaded(favProducts));
    } on NetworkException {
      emit(GetFavoriteError(
          "Couldn't change favorite item. Is the device online?"));
    }
  }
}
