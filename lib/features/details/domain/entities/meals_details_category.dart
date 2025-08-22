import 'package:equatable/equatable.dart';

class MealDetails extends Equatable {
  final String? id;
  final String? name;
  final String? category;
  final String? area;
  final String? instructions;
  final String? youtube;
  final MealDetailsImage? image;
  final List<Ingredient> ingredients;
  const MealDetails({
    required this.id,
    required this.ingredients,
    this.name,
    this.image,
    this.category,
    this.area,
    this.instructions,
    this.youtube,
  });

  @override
  List<Object?> get props => [id, name, image];

  @override
  bool get stringify => true;
}

class MealDetailsImage extends Equatable {
  final String baseUrl;

  const MealDetailsImage(this.baseUrl);
  String get small => '$baseUrl/small';
  String get medium => '$baseUrl/medium';
  String get large => '$baseUrl/large';

  @override
  List<Object?> get props => [baseUrl];

  @override
  bool get stringify => true;
}

class IngredientDetailsImage extends Equatable {
  final String name;
  static const baseUrl = "https://www.themealdb.com/images/ingredients";
  const IngredientDetailsImage(this.name);
  String get small => '$baseUrl/$name-small.png';
  String get medium => '$baseUrl/$name-medium.png';
  String get large => '$baseUrl/$name-large.png';

  @override
  List<Object?> get props => [name];

  @override
  bool get stringify => true;
}

class Ingredient {
  final String name;
  final String measure;
  IngredientDetailsImage? image;
  Ingredient({required this.name, required this.measure}) {
    image = IngredientDetailsImage(name);
  }
}
