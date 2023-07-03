// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic5_flutter_restaurant_app/data/models/responses/gmap_model.dart';
import 'package:fic5_flutter_restaurant_app/data/remote_datasources/gmap_datasource.dart';

part 'gmap_bloc.freezed.dart';
part 'gmap_event.dart';
part 'gmap_state.dart';

class GmapBloc extends Bloc<GmapEvent, GmapState> {
  final GmapDatasource datasource;
  GmapBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_GetCurrentLocation>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getCurrentPosition();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
