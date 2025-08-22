import 'package:aplazo_pt/core/errors/failure.dart';
import 'package:aplazo_pt/core/utils/typedefs.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/get_meal_by_id_response.dart';

abstract class DetailsRemoteDataSource {
  const DetailsRemoteDataSource();

  ResultFuture<GetMealByIdResponse> getMealById(String idMeal);
}

class DetailsRemoteDataSourceImpl implements DetailsRemoteDataSource {
  const DetailsRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  ResultFuture<GetMealByIdResponse> getMealById(String idMeal) async {
    try {
      final response = await _dio.get(
        'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$idMeal',
      );

      if (response.statusCode != 200) {
        throw ApiFailure(
          message: response.data['message'] ?? 'Error desconocido',
          statusCode: response.statusCode ?? 500,
        );
      }

      final json = response.data;
      final GetMealByIdResponse meals = GetMealByIdResponse.fromJson(json);
      return right(meals);
    } on ApiFailure catch (e) {
      return left(
        ApiFailure(
          message: "No se logró encontrar menú, intenta de nuevo más tarde.",
          statusCode: e.statusCode,
        ),
      );
    } on DioException catch (e) {
      return left(
        ApiFailure(
          message: "No fue posible solicitar el menú seleccionado.",
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    } catch (e) {
      return left(ApiFailure(message: "Error de conexión.", statusCode: 500));
    }
  }
}
