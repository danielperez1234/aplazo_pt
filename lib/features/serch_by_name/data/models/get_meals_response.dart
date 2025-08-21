class GetMealsByNameResponse {
  final List<Meal> meals;

  GetMealsByNameResponse({required this.meals});

  factory GetMealsByNameResponse.fromJson(Map<String, dynamic> json) =>
      GetMealsByNameResponse(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );
}

class Meal {
  final String id;
  final String name;
  final String? category;
  final String? area;
  final String? instructions;
  final String? thumbnailUrl;
  final String? tags;
  final String? youtubeUrl;
  final List<Ingredient> ingredients; // Consolidated list of ingredients
  final String? sourceUrl;
  final DateTime? dateModified;

  Meal({
    required this.id,
    required this.name,
    this.category,
    this.area,
    this.instructions,
    this.thumbnailUrl,
    this.tags,
    this.youtubeUrl,
    required this.ingredients,
    this.sourceUrl,
    this.dateModified,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<Ingredient> ingredientsList = [];
    // Agregamos los ingredientes en una lista para un mejor manejo
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      // paramos cuando esta vacio
      if (ingredient == null || ingredient.trim().isEmpty) {
        break;
      }

      ingredientsList.add(Ingredient(name: ingredient, measure: measure ?? ''));
    }

    return Meal(
      id: json["idMeal"],
      name: json["strMeal"],
      category: json["strCategory"],
      area: json["strArea"],
      instructions: json["strInstructions"],
      thumbnailUrl: json["strMealThumb"],
      tags: json["strTags"],
      youtubeUrl: json["strYoutube"],
      sourceUrl: json["strSource"],
      // Safely parse the date, returns null if invalid.
      dateModified: json["dateModified"] == null
          ? null
          : DateTime.tryParse(json["dateModified"]),
      ingredients: ingredientsList,
    );
  }
}

class Ingredient {
  final String name;
  final String measure;

  Ingredient({required this.name, required this.measure});
}
