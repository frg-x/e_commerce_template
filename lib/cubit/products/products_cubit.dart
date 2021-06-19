import 'package:bloc/bloc.dart';
import 'package:e_commerce_template/data/shop_repository.dart';
import 'package:e_commerce_template/model/product.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<GetProductsState> {
  final ShopRepository _shopRepository;

  late List<Product> allProducts;

  ProductsCubit(this._shopRepository, this.allProducts)
      : super(GetProductsInitial()) {
    getProducts();
  }

  Future<void> getProducts() async {
    try {
      emit(const GetProductsLoading());
      allProducts = await _shopRepository.fetchProducts();
      emit(GetProductsLoaded(allProducts));
    } on NetworkException {
      emit(GetProductsError("Couldn't fetch products. Is the device online?"));
    }
  }
}
