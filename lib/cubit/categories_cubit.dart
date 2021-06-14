import 'package:bloc/bloc.dart';
import 'package:e_commerce_template/data/shop_repository.dart';
import 'package:e_commerce_template/model/category.dart';
part 'categories_state.dart';

class CategoriesCubit extends Cubit<GetCategoriesState> {
  final ShopRepository _shopRepository;

  CategoriesCubit(this._shopRepository) : super(GetCategoriesInitial());

  Future<void> getCategories() async {
    try {
      emit(const GetCategoriesLoading());
      List<Category> products = await _shopRepository.fetchCategories();
      emit(GetCategoriesLoaded(products));
    } on NetworkException {
      emit(GetCategoriesError(
          "Couldn't fetch categories. Is the device online?"));
    }
  }
}
