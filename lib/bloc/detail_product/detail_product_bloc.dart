// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic5_flutter_restaurant_app/data/models/responses/add_product_response_model.dart';
import 'package:fic5_flutter_restaurant_app/data/remote_datasources/restaurant_datasource.dart';

part 'detail_product_bloc.freezed.dart';
part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  final RestaurantDatasource datasource;

  DetailProductBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Get>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getById(event.id);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
