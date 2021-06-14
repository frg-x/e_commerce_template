import 'package:bloc/bloc.dart';
import 'package:e_commerce_template/data/shop_repository.dart';
import 'package:e_commerce_template/model/advertisement.dart';
part 'ads_state.dart';

class AdsCubit extends Cubit<GetAdsState> {
  final ShopRepository _shopRepository;

  AdsCubit(this._shopRepository) : super(GetAdsInitial());

  Future<void> getAds() async {
    try {
      emit(const GetAdsLoading());
      List<Advertisement> ads = await _shopRepository.fetchAds();
      emit(GetAdsLoaded(ads));
    } on NetworkException {
      emit(GetAdsError("Couldn't fetch advertisements. Is the device online?"));
    }
  }
}
