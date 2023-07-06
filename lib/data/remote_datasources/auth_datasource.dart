import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic5_flutter_restaurant_app/data/models/requests/login_request_model.dart';
import 'package:fic5_flutter_restaurant_app/data/models/requests/register_request_model.dart';
import 'package:fic5_flutter_restaurant_app/data/models/responses/auth_response_model.dart';
import 'package:http/http.dart' as http;

import '../../common/constants.dart';

class AuthDataSources {
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel registerData) async {
    final response = await http.post(
      Uri.parse("${Constants.baseUrl}/api/auth/local/register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(registerData.toJson()),
    );

    if (response.statusCode == 200) {
      return Right(
        AuthResponseModel.fromJson(
          jsonDecode(response.body),
        ),
      );
    } else {
      return const Left(
        "API ERROR",
      );
    }
  }

  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel model) async {
    final response = await http.post(
      Uri.parse("${Constants.baseUrl}/api/auth/local"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      return Right(
        AuthResponseModel.fromJson(
          jsonDecode(response.body),
        ),
      );
    } else {
      return const Left(
        "API ERROR",
      );
    }
  }
}
