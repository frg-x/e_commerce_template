part of 'categories_cubit.dart';

abstract class GetCategoriesState {
  const GetCategoriesState();
}

class GetCategoriesInitial extends GetCategoriesState {
  const GetCategoriesInitial();
}

class GetCategoriesLoading extends GetCategoriesState {
  const GetCategoriesLoading();
}

class GetCategoriesError extends GetCategoriesState {
  final message;
  const GetCategoriesError(this.message);
}

class GetCategoriesLoaded extends GetCategoriesState {
  final List<Category> category;
  const GetCategoriesLoaded(this.category);

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
