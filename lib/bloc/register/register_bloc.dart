// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic5_flutter_restaurant_app/data/models/requests/register_request_model.dart';
import 'package:fic5_flutter_restaurant_app/data/models/responses/auth_response_model.dart';
import 'package:fic5_flutter_restaurant_app/data/remote_datasources/auth_datasource.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthDataSources dataSource;

  RegisterBloc(
    this.dataSource,
  ) : super(const _Initial()) {
    on<_Add>((event, emit) async {
      emit(const _Loading());
      final result = await dataSource.register(event.model);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
