import 'package:aplazo_pt/core/errors/failure.dart';
import 'package:aplazo_pt/core/utils/typedefs.dart';
import 'package:aplazo_pt/features/serch_by_name/data/models/get_meals_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class SearchByNameRemoteDataSource {
  const SearchByNameRemoteDataSource();

  ResultFuture<GetMealsByNameResponse> getMealsByChar(String char);
}

class SearchByNameRemoteDataSourceImpl implements SearchByNameRemoteDataSource {
  const SearchByNameRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  ResultFuture<GetMealsByNameResponse> getMealsByChar(String char) async {
    try {
      final response = await _dio.get(
        'https://www.themealdb.com/api/json/v1/1/search.php?s=$char',
      );

      if (response.data['meals'] == null || response.data['meals'] is String) {
        throw ApiFailure(
          message: response.data['meals'] ?? 'No se encontraron menús',
          statusCode: response.statusCode ?? 500,
        );
      }
      final json = response.data;
      final GetMealsByNameResponse meals = GetMealsByNameResponse.fromJson(
        json,
      );
      return right(meals);
    } on ApiFailure catch (e) {
      return left(e);
    } on DioException catch (e) {
      return left(
        ApiFailure(
          message: "No fue posible solicitar tus menús.",
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    } catch (e) {
      return left(ApiFailure(message: "Errror de conexión.", statusCode: 500));
    }
  }
}
