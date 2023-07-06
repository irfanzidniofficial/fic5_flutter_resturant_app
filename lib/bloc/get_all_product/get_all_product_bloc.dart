// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:fic5_flutter_restaurant_app/data/local_datasources/auth_local_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic5_flutter_restaurant_app/data/models/responses/products_response_model.dart';
import 'package:fic5_flutter_restaurant_app/data/remote_datasources/restaurant_datasource.dart';

part 'get_all_product_bloc.freezed.dart';
part 'get_all_product_event.dart';
part 'get_all_product_state.dart';

class GetAllProductBloc extends Bloc<GetAllProductEvent, GetAllProductState> {
  final RestaurantDatasource datasource;

  GetAllProductBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Get>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getAll();
      result.fold(
        (l) => emit(const _Error()),
        (r) => emit(_Success(r)),
      );
    });

    on<_GetByUserId>((event, emit) async {
      emit(const _Loading());
      final userId = await AuthLocalDatasource().getUserId();
      final result = await datasource.getByUserId(userId);
      result.fold(
        (l) => emit(const _Error()),
        (r) => emit(_Success(r)),
      );
    });
  }
}
