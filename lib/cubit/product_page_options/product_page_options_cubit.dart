import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_page_options_state.dart';

class ProductPageOptionsCubit extends Cubit<ProductPageOptionsState> {
  ProductPageOptionsCubit() : super(ProductPageOptionsInitial());

  List<Map<String, dynamic>> colorsList = [];
  List<Map<String, dynamic>> sizesList = [];

  void clearOptions() {
    colorsList = [];
    sizesList = [];
  }

  int _checkAllColors() {
    int i = 0;
    colorsList.forEach((element) {
      if (element['isActive']) i++;
    });
    return i;
  }

  int _checkAllSizes() {
    int i = 0;
    sizesList.forEach((element) {
      if (element['isActive']) i++;
    });
    return i;
  }

  String getSelectedColor() {
    if (sizesList.length > 0 && _checkAllColors() > 0) {
      return colorsList
          .firstWhere((element) => element['isActive'] == true)['title'];
    } else {
      return '';
    }
  }

  String getSelectedSize() {
    if (sizesList.length > 0 && _checkAllSizes() > 0) {
      return sizesList
          .firstWhere((element) => element['isActive'] == true)['title'];
    } else {
      return '';
    }
  }
}
