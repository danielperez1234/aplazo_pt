import 'dart:developer';

import 'package:aplazo_pt/core/errors/failure.dart';
import 'package:aplazo_pt/core/utils/typedefs.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/get_meals_by_category_response.dart';

abstract class HomeRemoteDataSource {
  const HomeRemoteDataSource();

  ResultFuture<GetMealsByCategoryResponse> getMealsByCategory(String category);
  ResultFuture<List<String>> getCategories();
}

class MealsByCategoryRemoteDataSourceImpl implements HomeRemoteDataSource {
  const MealsByCategoryRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  ResultFuture<GetMealsByCategoryResponse> getMealsByCategory(
    String category,
  ) async {
    try {
      final response = await _dio.get(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category',
      );

      if (response.statusCode != 200) {
        throw ApiFailure(
          message: response.data['message'] ?? 'Error desconocido',
          statusCode: response.statusCode ?? 500,
        );
      }
      log(response.data.toString());
      final json = response.data;
      final GetMealsByCategoryResponse meals =
          GetMealsByCategoryResponse.fromJson(json);
      return right(meals);
    } on ApiFailure catch (e) {
      log(e.message.toString());
      return left(
        ApiFailure(
          message:
              "No se logró conseguir tus menús, intenta de nuevo más tarde.",
          statusCode: e.statusCode,
        ),
      );
    } on DioException catch (e) {
      log(e.message.toString());
      return left(
        ApiFailure(
          message: "No fue posible solicitar tus menús.",
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    } catch (e) {
      log(e.toString());
      return left(ApiFailure(message: "Error de conexión.", statusCode: 500));
    }
  }

  @override
  ResultFuture<List<String>> getCategories() async {
    try {
      final response = await _dio.get(
        'https://www.themealdb.com/api/json/v1/1/list.php?c=list',
      );

      if (response.statusCode != 200) {
        throw ApiFailure(
          message: response.data['message'] ?? 'Error desconocido',
          statusCode: response.statusCode ?? 500,
        );
      }
      log(response.data.toString());
      final json = response.data;
      final List<dynamic> mealsJson = json['meals'] ?? [];
      final categories = mealsJson
          .map((e) => e['strCategory'] as String)
          .toList();
      return Right(categories);
    } on ApiFailure catch (e) {
      log(e.message.toString());
      return left(
        ApiFailure(
          message:
              "No se logró conseguir las categorias, intenta de nuevo más tarde.",
          statusCode: e.statusCode,
        ),
      );
    } on DioException catch (e) {
      log(e.message.toString());
      return left(
        ApiFailure(
          message: "No fue posible solicitar las categorias.",
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    } catch (e) {
      log(e.toString());
      return left(
        ApiFailure(
          message: "Errror de conexión con categorias.",
          statusCode: 500,
        ),
      );
    }
  }
}
