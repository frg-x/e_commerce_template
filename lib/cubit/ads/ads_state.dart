part of 'ads_cubit.dart';

abstract class GetAdsState {
  const GetAdsState();
}

class GetAdsInitial extends GetAdsState {
  const GetAdsInitial();
}

class GetAdsLoading extends GetAdsState {
  const GetAdsLoading();
}

class GetAdsError extends GetAdsState {
  final message;
  const GetAdsError(this.message);
}

class GetAdsLoaded extends GetAdsState {
  final List<Advertisement> ads;
  const GetAdsLoaded(this.ads);

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
