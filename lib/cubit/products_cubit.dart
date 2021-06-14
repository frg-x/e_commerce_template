import 'package:bloc/bloc.dart';
import 'package:e_commerce_template/data/shop_repository.dart';
import 'package:e_commerce_template/model/product.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<GetProductsState> {
  final ShopRepository _shopRepository;

  ProductsCubit(this._shopRepository) : super(GetProductsInitial());

  Future<void> getProducts() async {
    try {
      emit(const GetProductsLoading());
      List<Product> products = await _shopRepository.fetchProducts();
      emit(GetProductsLoaded(products));
    } on NetworkException {
      emit(GetProductsError("Couldn't fetch products. Is the device online?"));
    }
  }
}
