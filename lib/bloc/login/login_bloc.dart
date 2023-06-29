// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:fic5_flutter_restaurant_app/data/models/requests/login_request_model.dart';
import 'package:fic5_flutter_restaurant_app/data/models/responses/auth_response_model.dart';
import 'package:fic5_flutter_restaurant_app/data/remote_datasources/auth_datasource.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthDataSources dataSource;

  LoginBloc(
    this.dataSource,
  ) : super(const _Initial()) {
    on<_Add>((event, emit) async {
      emit(const _Loading());
      final result = await dataSource.login(event.model);

      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
