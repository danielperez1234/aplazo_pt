import 'package:equatable/equatable.dart';

class MealsSearchByCategory extends Equatable {
  final String? id;
  final String? name;
  final MealsSearchByNameImage? image;

  const MealsSearchByCategory({this.id, this.name, this.image});

  @override
  List<Object?> get props => [id, name, image];

  @override
  bool get stringify => true;
}

class MealsSearchByNameImage extends Equatable {
  final String baseUrl;

  const MealsSearchByNameImage(this.baseUrl);
  String get small => '$baseUrl/small';
  String get medium => '$baseUrl/medium';
  String get large => '$baseUrl/large';

  @override
  List<Object?> get props => [baseUrl];

  @override
  bool get stringify => true;
}
