part of '../pages/details_page.dart';

class _DetailsLoadedView extends StatelessWidget {
  const _DetailsLoadedView({required this.meals});
  final MealDetails meals;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  meals.image?.small ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                meals.instructions ?? 'No instructions provided.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            if (meals.ingredients.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Ingredients:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: meals.ingredients.length,
                itemBuilder: (context, index) {
                  final ingredient = meals.ingredients[index];
                  return AppIngredientTile(
                    name: ingredient.name,
                    image: ingredient.image?.small,
                    measure: ingredient.measure,
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
