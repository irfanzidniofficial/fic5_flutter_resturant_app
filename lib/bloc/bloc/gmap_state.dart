part of 'gmap_bloc.dart';

@freezed
class GmapState with _$GmapState {
  const factory GmapState.initial() = _Initial;
  const factory GmapState.loading() = _Loading;
  const factory GmapState.success(GmapModel model) = _Success;
  const factory GmapState.error(String error) = _Error;
}
