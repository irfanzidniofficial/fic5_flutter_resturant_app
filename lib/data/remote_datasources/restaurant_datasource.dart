import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic5_flutter_restaurant_app/data/local_datasources/auth_local_datasource.dart';
import 'package:fic5_flutter_restaurant_app/data/models/requests/add_product_request_model.dart';
import 'package:fic5_flutter_restaurant_app/data/models/responses/add_product_response_model.dart';
import 'package:fic5_flutter_restaurant_app/data/models/responses/products_response_model.dart';
import 'package:http/http.dart' as http;

import '../../common/constants.dart';

class RestaurantDatasource {
  Future<Either<String, ProductsResponseModel>> getAll() async {
    final response = await http.get(
      Uri.parse("${Constants.baseUrl}/api/restaurants"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Right(ProductsResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left("API ERROR");
    }
  }

  Future<Either<String, AddProductResponseModel>> getById(int id) async {
    final response = await http.get(
      Uri.parse("${Constants.baseUrl}/api/restaurants/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Right(AddProductResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left("API ERROR");
    }
  }

  Future<Either<String, AddProductResponseModel>> addProduct(
      AddProductRequestModel model) async {
    final token = await AuthLocalDatasource().getToken();
    final response = await http.post(
      Uri.parse("${Constants.baseUrl}/api/restaurants"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(model.toString()),
    );

    if (response.statusCode == 200) {
      return Right(AddProductResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left("API ERROR");
    }
  }
}
