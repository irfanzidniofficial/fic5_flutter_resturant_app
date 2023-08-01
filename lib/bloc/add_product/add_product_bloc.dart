// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic5_flutter_restaurant_app/data/models/requests/add_product_request_model.dart';
import 'package:fic5_flutter_restaurant_app/data/models/responses/add_product_response_model.dart';
import 'package:fic5_flutter_restaurant_app/data/remote_datasources/restaurant_datasource.dart';
import 'package:image_picker/image_picker.dart';

part 'add_product_bloc.freezed.dart';
part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final RestaurantDatasource datasource;
  AddProductBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_Add>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.addProduct(event.model);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
