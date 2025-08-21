import 'package:aplazo_pt/features/home/domain/repositories/home_repository.dart';
import 'package:aplazo_pt/core/errors/failure.dart';
import 'package:aplazo_pt/features/home/domain/usecases/get_categories.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_categories_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late GetCategoriesUseCase usecase;
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = GetCategoriesUseCase(mockHomeRepository);
  });

  final tCategories = ['Beef', 'Chicken', 'Dessert', 'Lamb'];
  final tServerFailure = ApiFailure(message: '', statusCode: 500);

  group('GetCategoriesUseCase', () {
    test('Regresa la lista de categorias de comida', () async {
      // Arrange
      when(
        mockHomeRepository.getCategories(),
      ).thenAnswer((_) async => Right(tCategories));

      // Act
      final result = await usecase();

      // Assert
      expect(result, Right(tCategories));
      verify(mockHomeRepository.getCategories());
      verifyNoMoreInteractions(mockHomeRepository);
    });

    test('debe regresar error cuando falla la peticion', () async {
      // Arrange
      when(
        mockHomeRepository.getCategories(),
      ).thenAnswer((_) async => Left(tServerFailure));

      // Act
      final result = await usecase();

      // Assert
      expect(result, Left(tServerFailure));
      verify(mockHomeRepository.getCategories());
      verifyNoMoreInteractions(mockHomeRepository);
    });
  });
}
