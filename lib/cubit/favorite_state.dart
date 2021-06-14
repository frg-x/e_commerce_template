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
  final List<String> favoriteList;
  const GetFavoriteLoaded(this.favoriteList);

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}

class ToggleFavorite extends GetFavoriteState {
  const ToggleFavorite();

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
